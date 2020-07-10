//
//  ViewModelLoadingState.swift
//  Society
//
//  Created by Adam Oxley on 02/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

enum ViewModelLoadingState<T> {
    case pending
    case loading
    case complete
    case error(T)
}
