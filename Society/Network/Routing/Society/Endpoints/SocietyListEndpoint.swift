//
//  SocietyListEndpoint.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct SocietyListEndpoint: EndPointType {
    
    var path: HTTPEndpoint {
        return .societies
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
