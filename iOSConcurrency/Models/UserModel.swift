//
//  UserModel.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct UserModel: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    
//    let test: String // to throw an error
}
