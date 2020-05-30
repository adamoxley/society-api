//
//  URLStore.swift
//  Society
//
//  Created by Adam Oxley on 07/01/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

public struct URLStore {
    
    public static var APIURL: URL = {
        guard let stringURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String else {
            preconditionFailure("Invalid API URL in Bundle")
        }
        
        guard let url = URL(string: stringURL) else {
            preconditionFailure("Could not convert Bundle API_URL to valid URL")
        }
        
        return url
    }()
}
