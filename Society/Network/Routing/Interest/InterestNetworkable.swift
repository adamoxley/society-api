//
//  InterestNetworkable.swift
//  Society
//
//  Created by Adam Oxley on 30/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

protocol InterestNetworkable {
    func fetch() -> AnyPublisher<InterestListResponse, HTTPError>
}
