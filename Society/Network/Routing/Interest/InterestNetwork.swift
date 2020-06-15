//
//  InterestNetwork.swift
//  Society
//
//  Created by Adam Oxley on 30/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

class InterestNetwork {
    
    private let networkService: NetworkServicable
    
    init() {
        self.networkService = APIService()
    }
}

extension InterestNetwork {
 
    typealias ListResponse = InterestListResponse
    typealias ErrorType = HTTPError
    
    func list() -> AnyPublisher<ListResponse, ErrorType> {
        let endpoint = InterestEndpoint.interests
        return networkService.fetch(endpoint: endpoint)
    }
}
