//
//  PostsListViewModel.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    var userId: Int?
    
    func fetchPosts() {
#if DEBUG
        if posts.count > 0 {
            return
        }
#endif
        if let userId = userId {
            let apiService = APIServiceCH(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            /// Apply delay to show Progress Spinner
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                apiService.getJSON { (result: Result<[PostModel], APIError>) in
                    /// Code for Progress Spinner
                    defer {
                        DispatchQueue.main.async {
                            self.isLoading.toggle()
                        }
                    }
                    switch result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert = true
                            self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and steps to reproduce."
                        }
                    }
                }
//            }
        }
    }
}

extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = PostModel.mockSingleUsersPostsArray
        }
    }
}
