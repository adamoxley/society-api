//
//  User.swift
//  Society
//
//  Created by Adam Oxley on 14/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let data: User
}

struct User: Decodable {
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
    
    let email: String
}

protocol UserNetwork {
    func register(name: String, email: String, password: String, _ completion: @escaping (Result<User, Error>) -> Void)
    func login(email: String, password: String, _ completion: @escaping (Result<AuthToken, Error>) -> Void)
    func createUser(_ completion: @escaping (Result<User, Error>) -> Void)
    func retrieveUser(_ completion: @escaping (Result<User, Error>) -> Void)
    func retrieveUser(with uuid: String, _ completion: @escaping (Result<User, Error>) -> Void)
}
