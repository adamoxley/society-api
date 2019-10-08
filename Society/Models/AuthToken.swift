//
//  AuthToken.swift
//  Society
//
//  Created by Adam Oxley on 21/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import Foundation

// Model describing an authentication JWT token
struct AuthToken: Decodable {
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    let token: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
    }
}
