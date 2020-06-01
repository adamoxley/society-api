//
//  InterestViewModel.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Kingfisher

struct InterestViewModel: ViewModel {
    
    typealias Model = Interest
    
    private let item: Model
    
    var id: UUID {
        return item.id
    }
    
    var name: String {
        return item.name
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

extension InterestViewModel: Hashable {
    static func == (lhs: InterestViewModel, rhs: InterestViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
