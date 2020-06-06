//
//  SocietyViewModel.swift
//  Society
//
//  Created by Adam Oxley on 02/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct SocietyViewModel: ViewModel {
    
    typealias Model = Society
    
    internal let item: Model
    
    var id: UUID {
        return item.id
    }
    
    var name: String {
        return item.name
    }
    
    var memberCount: String {
        return "\(item.memberCount) Members"
    }
    
    var joinState: Society.JoinState {
        return item.state
    }
    
    var imageURL: URL {
        guard let imageURL = item.imageURL else {
            return URL(fileReferenceLiteralResourceName: "iPad")
        }
        
        return imageURL
    }
    
    init(item: Model) {
        self.item = item
    }
}

extension SocietyViewModel: Hashable {
    static func == (lhs: SocietyViewModel, rhs: SocietyViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
