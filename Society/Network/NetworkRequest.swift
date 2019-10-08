//
//  NetworkRequest.swift
//  Society
//
//  Created by Adam Oxley on 14/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case notFound
    case unauthorised
    case unauthenticated
}

class NetworkRequest {

    private let bundleURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String
    private let session: URLSession
    let decoder = JSONDecoder()
    
    internal init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }

    internal func POST(path: String, parameters: [String: Any],
                      completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let bundleURL = bundleURL, let APIURL = URL(string: bundleURL) else {
            completion(.failure(.badURL))
            return
        }

        var request = URLRequest(url: APIURL.appendingPathComponent(path))
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

        dataTask(request: request, method: "POST", completion: completion)
    }

    internal func PUT(path: String, parameters: [String: Any],
                      completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let bundleURL = bundleURL, let APIURL = URL(string: bundleURL) else {
            completion(.failure(.badURL))
            return
        }

        let request = URLRequest(url: APIURL.appendingPathComponent(path))
        dataTask(request: request, method: "PUT", completion: completion)
    }

    internal func GET(path: String, request: URLRequest,
                     completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let bundleURL = bundleURL, let APIURL = URL(string: bundleURL) else {
            completion(.failure(.badURL))
            return
        }

        let request = URLRequest(url: APIURL.appendingPathComponent(path))
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func dataTask(request: URLRequest, method: String,
                          completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        var request = request
        request.httpMethod = method
        request.applyHeaders()

        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.badRequest))
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.badRequest))
                return
            }
            
            switch response.statusCode {
            case (200...299): completion(.success(data))
            case 400: completion(.failure(.badRequest))
            case 401: completion(.failure(.unauthenticated))
            case 403: completion(.failure(.unauthorised))
            case 404: completion(.failure(.notFound))
            default: completion(.failure(.badRequest))
            }
        }.resume()
    }
}

extension URLRequest {
    mutating func applyHeaders() {
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("application/json", forHTTPHeaderField: "Accept")
    }
}
