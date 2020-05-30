//
//  InterestViewModel.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct InterestViewModel: ViewModel {
    
    typealias Model = Interest
    
    private let item: Model
    
    var id: UUID {
        return item.id
    }
    
    var name: String {
        return item.name
    }
    
    var image: UIImage? {
        return UIImage(named: "iPad")
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
