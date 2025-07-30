//
//  UsersListViewModel.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isLoading: Bool = false
    
    func fetchUsers() {
#if DEBUG
        if users.count > 0 {
            return
        }
#endif
        let apiService = APIServiceCH(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        /// Apply delay to show Progress Spinner
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            apiService.getJSON { (result: Result<[UserModel], APIError>) in
                /// Code for Progress Spinner
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = UserModel.mockUsers
        }
    }
}
