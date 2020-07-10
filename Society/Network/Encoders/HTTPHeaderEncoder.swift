//
//  HTTPHeaderEncoder.swift
//  SocietyCore
//
//  Created by Adam Oxley on 09/07/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct HTTPHeaderEncoder: ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with headers: [(header: String, value: String)]) throws {
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
    }
}
