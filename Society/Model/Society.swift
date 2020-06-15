//
//  Society.swift
//  Society
//
//  Created by Adam Oxley on 02/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct Society {
    
    enum JoinState: Int, Codable {
    case pending
    case join
    case joined
    case leave
    }
    
    var id: UUID
    var name: String
    var memberCount: Int
    var state: JoinState
    var imageURL: URL?
    var comment: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case memberCount = "member_count"
        case state
        case imageURL = "image_url"
    }
}

extension Society: Codable {}
