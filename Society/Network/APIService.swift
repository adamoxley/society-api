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
        URLPathEncoder.resolve(url: &url, for: endpoint.path)
        
        var request = URLRequest(url: url)
                
        // Populate the URL with any parameters from the endpoint
        if let queryItems = endpoint.queryItems {
            URLParameterEncoder.encode(urlRequest: &request, with: queryItems)
        }
                
        // Add on the HTTP method
        request.httpMethod = endpoint.method.rawValue
        
        // Add the HTTP body if the endpoint is a POST
        if endpoint.method == .POST {
            do {
                if let body = endpoint.body {
                    try JSONParameterEncoder.encode(urlRequest: &request, with: body)
                } else {
                    // It is valid for a POST to not contain a body, in this case
                    // set the header Content-Length: 0 on the URLRequest
                    let headers = [(header: "Content-Length", value: "0")]
                    try? HTTPHeaderEncoder.encode(urlRequest: &request, with: headers)
                }
            } catch {
                let httpError = error as? HTTPError ?? .encodingFailure
                return Fail(error: httpError).eraseToAnyPublisher()
            }
        }
        
        let decoder = JSONDecoder()

        // Perform the request
        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { result in
            guard let httpResponse = result.response as? HTTPURLResponse else {
                throw HTTPError.invalidServerResponse
            }

            switch httpResponse.statusCode {
            case 200, 201:
                do { return try decoder.decode(T.self, from: result.data) }
                catch { throw HTTPError.decodingError }
            case 204: return EmptyResponse() as! T // Todo: Probably crashes
            case 300...399: throw HTTPError.redirect
            case 400: throw HTTPError.badRequest
            case 401: throw HTTPError.unauthorised
            case 403: throw HTTPError.unauthenticated
            case 404: throw HTTPError.notFound
            case 405...499: throw HTTPError.clientError
            case 500...599: throw HTTPError.invalidServerResponse
            default: throw HTTPError.badRequest
            }
        }
        .mapError {
            return $0 as? HTTPError ?? .unknown
        }
        .eraseToAnyPublisher()
    }
}
