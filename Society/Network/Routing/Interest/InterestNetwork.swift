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
    
    init(networkService: NetworkServicable = APIService()) {
        self.networkService = networkService
    }
}

extension InterestNetwork {
 
    typealias ListResponseType = ListResponse<Interest>
    typealias ErrorType = HTTPError
    
    func list() -> AnyPublisher<ListResponseType, ErrorType> {
        let endpoint = InterestEndpoint.interests
        return networkService.fetch(endpoint: endpoint)
    }
}
