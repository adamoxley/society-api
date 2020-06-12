//
//  FetchableResponse.swift
//  Society
//
//  Created by Adam Oxley on 08/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

protocol FetchableResponse: Codable {
    
    associatedtype Model: Codable
}
