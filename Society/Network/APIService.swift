//
//  APIService.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

struct APIService: NetworkServicable {

    func fetch<T, EndPoint: EndPointType>(endpoint: EndPoint) -> DecodableResponse<T> {
        var url = endpoint.baseURL
        
        // Append onto the request URL the endpoint path
        URLPathEncoder.resolve(url: &url, for: endpoint.path.rawValue)
        
        var request = URLRequest(url: url)
                
        // Populate the URL with any parameters from the endpoint
        URLParameterEncoder.encode(urlRequest: &request, with: endpoint.queryItems)
                
        // Add on the HTTP method
        request.httpMethod = endpoint.method.rawValue
        
        // Add the HTTP body if the endpoint is a POST
        if endpoint.method == .POST {
            request.httpBody = nil
        }
        
        let decoder = JSONDecoder()

        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { result in
            guard let httpResponse = result.response as? HTTPURLResponse else {
                throw HTTPError.invalidServerResponse
            }
            
            if httpResponse.statusCode == 404 {
                throw HTTPError.notFound
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.badRequest
            }
            
            return try decoder.decode(T.self, from: result.data)
        }
        .mapError {
            print($0)
            return $0 as? HTTPError ?? .unknown
        }
        .eraseToAnyPublisher()
    }
}
