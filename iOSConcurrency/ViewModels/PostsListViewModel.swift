//
//  PostsListViewModel.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var userId: Int?
    
    func fetchPosts() {
#if DEBUG
        if posts.count > 0 {
            return
        }
#endif
        if let userId = userId {
            let apiService = APIServiceCH(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            apiService.getJSON { (result: Result<[PostModel], APIError>) in
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    print(error)
                }
            }
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
