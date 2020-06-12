//
//  Fetchable.swift
//  Society
//
//  Created by Adam Oxley on 08/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

protocol Fetchable {
    
    associatedtype FetchResponse: FetchableResponse
    associatedtype ErrorType: Error
    
    func fetch() -> AnyPublisher<FetchResponse, ErrorType>
}

