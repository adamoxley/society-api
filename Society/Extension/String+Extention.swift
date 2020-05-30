//
//  SocietyStringExtentions.swift
//  society
//
//  Created by Adam Oxley on 28/05/2018.
//  Copyright © 2018 Adam Oxley. All rights reserved.
//

import UIKit

extension String {
    
    // Check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    // Validate email
    var isValidEmail: Bool {
        if self.contains(" ") {
            return false
        }

        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        
        let range = NSMakeRange(0, NSString(string: self).length)
        let allMatches = dataDetector.matches(in: self,
                                              options: [],
                                              range: range)
        
        if allMatches.count == 1,
            allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return true
        }

        return false
    }
    
    // Validate username
    var isValidUsername: Bool {
        return self.count >= 3 && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    // Check a string only has alphanumeric values
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    // Validate password
    var isValidPassword: Bool {
        return !isEmpty && self.count >= 6
    }
}
