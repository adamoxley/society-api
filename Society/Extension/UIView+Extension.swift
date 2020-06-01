//
//  UIView+Extension.swift
//  Society
//
//  Created by Adam Oxley on 31/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

extension UIView {
    
    func rounded(by radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func setHiddenState(_ hidden: Bool) {
        Self.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
}
