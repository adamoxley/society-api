//
//  UIColor+Extension.swift
//  Society
//
//  Created by Adam Oxley on 20/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

enum AssetColors: String {
    // Core Colours
    case action
    case black10
    case black20
    case black30
    case black40
    case black
    case destructive
    case neutral
    case positive
    case primaryGrey
    case secondaryGrey
    case tiercharyGrey
    case white
    
    // UI Elements
    case borderHighlightState
    case highlightState
    case viewBackground
    case cellBackground
}

extension UIColor {

    static func asset(_ name: AssetColors) -> UIColor {
        // Ensure we have the colour from the asset catalog
        if let color = UIColor(named: name.rawValue) {
            return color
        }
        
        // Otherwise return a default one, so we aren't
        // returning an optional UIColor
        return UIColor.white
    }
}
