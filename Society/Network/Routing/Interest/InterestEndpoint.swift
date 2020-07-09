//
//  InterestEndpoint.swift
//  Society
//
//  Created by Adam Oxley on 29/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

enum InterestEndpoint {
    case interests
}

extension InterestEndpoint: EndPointType {
    
    var path: String {
        switch self {
        case .interests:
            return "interests"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .interests:
            return .GET
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: HTTPBody? {
        return nil
    }
}

