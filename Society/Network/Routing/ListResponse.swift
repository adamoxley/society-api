//
//  ListResponse.swift
//  SocietyCore
//
//  Created by Adam Oxley on 09/07/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct ListResponse<T>: Decodable where T: Decodable {
    
    typealias Model = T
    var data: [Model]
}
