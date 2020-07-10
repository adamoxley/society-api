//
//  EndPointType.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias HTTPBody = [String: Any]

protocol EndPointType {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: HTTPHeaders? { get }
    var body: HTTPBody? { get }
}

extension EndPointType {
    
    var baseURL: URL {
        return URLStore.APIURL
    }
}
