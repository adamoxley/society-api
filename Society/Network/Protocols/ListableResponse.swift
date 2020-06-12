//
//  ListableResponse.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

protocol ListableResponse: Codable {
    
    associatedtype Model: Codable
    
    var data: [Model] { get }
}
