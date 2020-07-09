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
    
    init(networkService: NetworkServicable = APIService()) {
        self.networkService = networkService
    }
}

extension SocietyNetwork {
    
    typealias ListResponseType = ListResponse<Society>
    typealias DetailResponse = Society
    typealias ErrorType = HTTPError
    
    func list() -> AnyPublisher<ListResponseType, ErrorType> {
        let endpoint = SocietyEndpoint.societies
        return networkService.fetch(endpoint: endpoint)
    }
    
    func fetch(id: UUID) -> AnyPublisher<DetailResponse, ErrorType> {
        let endpoint = SocietyEndpoint.society(id: id)
        return networkService.fetch(endpoint: endpoint)
    }
}
