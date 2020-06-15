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
    
    internal let model: Model
    
    var id: UUID {
        return model.id
    }
    
    var name: String {
        return model.name
    }
    
    var memberCount: String {
        return "\(model.memberCount) Members"
    }
    
    var joinState: Society.JoinState {
        return model.state
    }
    
    var imageURL: URL {
        guard let imageURL = model.imageURL else {
            return URL(fileReferenceLiteralResourceName: "iPad")
        }
        
        return imageURL
    }
    
    var comment: String? {
        return model.comment
    }
    
    init(model: Model) {
        self.model = model
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
