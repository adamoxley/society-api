//
//  UIImageView+Extension.swift
//  Society
//
//  Created by Adam Oxley on 25/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func rounded(by radius: CGFloat = 10) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    public func loadImage(at url: URL) {
        return
    }
    
    public func cancelImageLoad() {
        return
    }
}
