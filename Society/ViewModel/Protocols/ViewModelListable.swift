//
//  ViewModelListable.swift
//  Society
//
//  Created by Adam Oxley on 02/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

protocol ViewModelListable: class {
    
    associatedtype ViewModelType: ViewModel
    associatedtype ErrorType: Error
    associatedtype Service: Listable
    
    var service: Service { get }
    var cancellable: Set<AnyCancellable> { get set }
    
    var dataSource: [ViewModelType] { get }
    var state: ViewModelLoadingState<ErrorType> { get set }
    
    init(with service: Service)
    
    func list()
}
