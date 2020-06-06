//
//  EndPointType.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    var baseURL: URL { get }
    var path: HTTPEndpoint { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndPointType {
    
    var baseURL: URL {
        return URLStore.APIURL
    }
}
