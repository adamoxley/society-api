//
//  Society.swift
//  Society
//
//  Created by Adam Oxley on 02/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct Society: Codable {

    enum JoinState: Int, Codable {
    case pending = 1
    case join
    case joined
    }
    
    var id: UUID
    var name: String
    var memberCount: Int
    var state: JoinState
    var imageURL: URL?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case memberCount = "member_count"
        case state
        case imageURL = "image_url"
        case description
    }
}
