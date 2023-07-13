//
//  NetworkService.swift
//  CarArt
//
//  Created by Muzammal Shahzad on 6/6/23.
//

import UIKit

extension NetworkService {
    
    func fetchUserList(completion: @escaping (Result<UserList, Error>) -> Void){
        request(route: .users, method: .get, completion: completion)
    }
    
    func fetchSingleuser(for userID: Int?, completion: @escaping (Result<SingleUser, Error>) -> Void ){
        request(route: .singleUser(userID ?? 0), method: .get, completion: completion)
    }
    
    func fetchSearchUser(for userID: String?, completion: @escaping (Result<UserList, Error>) -> Void ){
        request(route: .searchUser(userID ?? ""), method: .get, completion: completion)
    }
    
    func fetchUserCart(for userID: Int, completion: @escaping (Result<UserCart, Error>) -> Void ){
        request(route: .getUserCart(userID), method: .get, completion: completion)
    }
    
    func fetchUserPost(for userID: Int, completion: @escaping (Result<UserPosts, Error>) -> Void ){
        request(route: .getUserPost(userID), method: .get, completion: completion)
    }
    
    func fetchUserTodo(for userID: Int, completion: @escaping (Result<UserTodos, Error>) -> Void ){
        request(route: .getUserTodo(userID), method: .get, completion: completion)
    }
    
    func fetchFilterUser(for eyeColor: String, completion: @escaping (Result<UserList, Error>) -> Void ){
        let parameters: [String: Any] = [
            "key": "eyeColor",
            "value": eyeColor
        ]
        request(route: .filterUser(key: "eyeColor", value: "Amber"), method: .get, completion: completion)
    }
    
}

struct NetworkService {

    static let shared = NetworkService()

    private init() {}
    
    private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        print(route)

        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }

    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }


    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.path
        print(urlString)
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue

        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}




enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpStatusCode(Int)
}

