//
//  UserTodos.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/26/23.
//

import Foundation

// MARK: - UserTodos
struct UserTodos: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}
