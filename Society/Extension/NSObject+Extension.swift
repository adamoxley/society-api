//
//  NSObject+Extension.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

extension NSObject {

    static var identifier: String {
        return String(describing: self)
    }
}
