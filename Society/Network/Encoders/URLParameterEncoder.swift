//
//  URLParameterEncoder.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    
    typealias Parameters = [URLQueryItem]
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) {
        guard parameters.isEmpty, let url = urlRequest.url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
        }

        components.queryItems = parameters
        urlRequest.url = components.url
    }
}
