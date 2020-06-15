//
//  SocietyListCellViewModel.swift
//  Society
//
//  Created by Adam Oxley on 14/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct SocietyListCellViewModel: ViewModel {
    
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
    
    init(model: Model) {
        self.model = model
    }
}

extension SocietyListCellViewModel: Hashable {
    static func == (lhs: SocietyListCellViewModel, rhs: SocietyListCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
