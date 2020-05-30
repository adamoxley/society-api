//
//  URLPathEncoder.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

struct URLPathEncoder {
    
    static func resolve(url: inout URL, for path: String) {
        url = url.appendingPathComponent(path)
    }
}
