//
//  ParameterEncoder.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    
    associatedtype Parameters
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
