//
//  InterestListResponse.swift
//  Society
//
//  Created by Adam Oxley on 30/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct InterestListResponse: ListableResponse {
    
    typealias Model = Interest
    
    var data: [Model]
}
