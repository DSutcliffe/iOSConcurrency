//
//  Post.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/posts
// Single User's Posts: https://jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
