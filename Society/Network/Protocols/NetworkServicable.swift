//
//  NetworkServicable.swift
//  Society
//
//  Created by Adam Oxley on 29/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

typealias DecodableResponse<T> = AnyPublisher<T, HTTPError> where T: Decodable

protocol NetworkServicable {

    func fetch<T, EndPoint: EndPointType>(endpoint: EndPoint) -> DecodableResponse<T>
}
