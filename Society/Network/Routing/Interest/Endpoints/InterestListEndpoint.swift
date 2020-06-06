//
//  InterestListEndpoint.swift
//  Society
//
//  Created by Adam Oxley on 29/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct InterestListEndpoint: EndPointType {
    
    var path: HTTPEndpoint {
        return .interests
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
