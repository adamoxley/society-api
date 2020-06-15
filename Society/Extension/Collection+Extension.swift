//
//  Collection+Extension.swift
//  Society
//
//  Created by Adam Oxley on 14/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
