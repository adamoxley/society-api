//
//  SocietyListResponse.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct SocietyListResponse: Decodable {
    
    typealias Model = Society
    
    var data: [Society]
}
