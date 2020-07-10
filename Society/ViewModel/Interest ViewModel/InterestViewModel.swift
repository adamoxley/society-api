//
//  InterestViewModel.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct InterestViewModel: ViewModel {
    
    typealias Model = Interest
    
    var model: Model
    
    var id: UUID {
        return model.id
    }
    
    var name: String {
        return model.name
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

extension InterestViewModel: Hashable {
    static func == (lhs: InterestViewModel, rhs: InterestViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
