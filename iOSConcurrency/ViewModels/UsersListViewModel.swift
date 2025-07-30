//
//  UsersListViewModel.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    
    func fetchUsers() {
#if DEBUG
        if users.count > 0 {
            return
        }
#endif
        let apiService = APIServiceCH(urlString: "https://jsonplaceholder.typicode.com/users")
        apiService.getJSON { (result: Result<[UserModel], APIError>) in
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

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = UserModel.mockUsers
        }
    }
}
