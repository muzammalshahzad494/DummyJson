//
//  Route.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/9/23.
//

import Foundation


enum Route {
    
    static let baseUrl = "https://dummyjson.com/"
    
    case products
    case carts
    
    case users
    case addUser
    case singleUser(Int)
    case updateUser(Int)
    case deleteUser(Int)
    case searchUser(String)
    case filterUser(key: String, value: String)
    case limitAndSkipUser
    case getUserCart(Int)
    case getUserPost(Int)
    case getUserTodo(Int)
    
    
    
    case posts
    case comments
    case quotes
    case todo
    
    var path: String {
        switch self {
        case .products:
            return "products"
            
        case .carts:
            return "carts"
            
        case .posts:
            return "posts"
            
        case .comments:
            return "comments"
            
        case .quotes:
            return "quotes"
            
        case .todo:
            return "todo"
            
        case .users:
            return "users"
            
        case .singleUser(let userId):
            return "users/\(userId)"
            
            
        case .addUser:
            return "users/add"
            
        case .updateUser(let userId):
            return "users/\(userId)"
            
        case .deleteUser(let userId):
            return "users/\(userId)"
            
        case .searchUser(let userId):
            return "users/search?q=\(userId)"
            
        case .filterUser:
            return "users/filter"
            
        case .limitAndSkipUser:
            return "users/add"
            
        case .getUserCart(let userId):
            return "users/\(userId)/carts"
            
        case .getUserPost(let userId):
            return "users/\(userId)/posts"
            
        case .getUserTodo(let userId):
            return "users/\(userId)/todos"
            
        }
    }
    
}












enum Method: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}


enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrl:
            return "HEYYY!!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
