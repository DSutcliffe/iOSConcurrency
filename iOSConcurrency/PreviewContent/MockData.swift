//
//  MockData.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

extension UserModel {
    static var mockUsers: [UserModel] {
        Bundle.main.decode([UserModel].self .self, from: "users.json")
    }
    
    static var mockSingleUser: UserModel {
        Self.mockUsers[0]
    }
}

extension PostModel {
    static var mockPosts: [PostModel] {
        Bundle.main.decode([PostModel].self .self, from: "posts.json")
    }
    
    static var mockSinglePost: PostModel {
        Self.mockPosts[0]
        
    }
    
    static var mockSingleUsersPostsArray: [PostModel] {
        Self.mockPosts.filter { $0.userId == 1 }
    }
}
