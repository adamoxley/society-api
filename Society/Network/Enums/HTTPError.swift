//
//  HTTPError.swift
//  Society
//
//  Created by Adam Oxley on 28/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case badURL
    case badRequest
    case notFound
    case redirect
    case unauthorised
    case unauthenticated
    case encodingFailure
    case clientError
    case invalidServerResponse
    case decodingError
    case unknown
}
