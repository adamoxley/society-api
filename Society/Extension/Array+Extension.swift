//
//  Array+Extension.swift
//  Society
//
//  Created by Adam Oxley on 30/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter{ seen.insert($0).inserted }
    }
}
