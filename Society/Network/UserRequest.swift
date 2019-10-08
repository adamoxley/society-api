//
//  UserRequest.swift
//  Society
//
//  Created by Adam Oxley on 14/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import Foundation

class UserRequest: NetworkRequest, UserNetwork {
    
    func register(name: String, email: String, password: String,
        _ completion: @escaping (Result<User, Error>) -> Void) {
        
        let parameters = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        POST(path: "/register", parameters: parameters) { (result) in
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let data):
                do {
                    let user = try self.decoder.decode(User.self, from: data)
                    return completion(.success(user))
                } catch let error {
                    return completion(.failure(error))
                }
            }
        }
    }
    
    func login(email: String, password: String,
               _ completion: @escaping (Result<AuthToken, Error>) -> Void) {
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        POST(path: "/auth", parameters: parameters) { (result) in
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let data):
                do {
                    let authToken = try self.decoder.decode(AuthToken.self, from: data)
                    print(authToken)
                    return completion(.success(authToken))
                } catch let error {
                    return completion(.failure(error))
                }
            }
        }
    }
    
    func createUser(_ completion: @escaping (Result<User, Error>) -> Void) {
        
    }

    func retrieveUser(_ completion: @escaping (Result<User, Error>) -> Void) {
        
    }
    
    func retrieveUser(with uuid: String,
                      _ completion: @escaping (Result<User, Error>) -> Void) {
    }
}
