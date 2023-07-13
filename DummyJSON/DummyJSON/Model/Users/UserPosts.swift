//
//  UserPosts.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/26/23.
//

import Foundation

// MARK: - UserPosts
struct UserPosts: Codable {
    let posts: [Post]
    let total, skip, limit: Int
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let title, body: String
    let userID: Int
    let tags: [String]
    let reactions: Int

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case userID = "userId"
        case tags, reactions
    }
}
