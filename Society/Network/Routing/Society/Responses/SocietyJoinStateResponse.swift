//
//  SocietyJoinStateResponse.swift
//  SocietyCore
//
//  Created by Adam Oxley on 10/07/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct SocietyJoinStateResponse: Decodable {
    
    var state: Society.JoinState
    var id: UUID
}
