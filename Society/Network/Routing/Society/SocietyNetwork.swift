//
//  SocietyNetwork.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

class SocietyNetwork {
    
    private let networkService: NetworkServicable
    
    init() {
        self.networkService = APIService()
    }
}

extension SocietyNetwork: Listable {
    
    typealias ListResponse = SocietyListResponse
    typealias ErrorType = HTTPError
    
    func list() -> AnyPublisher<ListResponse, ErrorType> {
        let endpoint = SocietyEndpoint.societies
        return networkService.fetch(endpoint: endpoint)
    }
    
    func join() -> AnyPublisher<EmptyResponse, ErrorType> {
        let endpoint = SocietyEndpoint.societies
        return networkService.fetch(endpoint: endpoint)
    }
}
