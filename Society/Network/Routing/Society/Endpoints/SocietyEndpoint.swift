//
//  SocietyEndpoint.swift
//  Society
//
//  Created by Adam Oxley on 07/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

enum SocietyEndpoint {
    case societies
    case society(id: UUID)
    case join(id: UUID)
    case leave(id: UUID)
}

extension SocietyEndpoint: EndPointType {
    
    var path: String {
        switch self {
        case .societies:
            return "societies"
        case .society(let id):
            return "society/\(id)"
        case .join(let id):
            return "society/\(id)/join"
        case .leave(let id):
            return "society/\(id)/leave"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .societies:
            return .GET
        case .society:
            return .GET
        case .join:
            return .POST
        case .leave:
            return .POST
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: HTTPBody? {
        switch self {
        case .join: return [:]
        default: return nil
        }
    }
}
