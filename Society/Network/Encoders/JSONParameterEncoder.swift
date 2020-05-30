//
//  JSONParameterEncoder.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    typealias Parameters = [String: Any]
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let JSONData = try? JSONSerialization.data(withJSONObject: parameters) else {
            throw HTTPError.encodingFailure
        }
        
        urlRequest.httpBody = JSONData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    }
}
