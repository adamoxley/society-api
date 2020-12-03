//
//  InterestListViewModel.swift
//  Society
//
//  Created by Adam Oxley on 27/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

class InterestListViewModel {

    typealias ViewModelType = InterestViewModel
    typealias ErrorType = HTTPError
    typealias Service = InterestNetwork
    
    var service: Service
    var cancellable: Set<AnyCancellable>
    
    @Published internal var dataSource: [ViewModelType] = []
    @Published internal var state: ViewModelLoadingState<HTTPError> = .loading
    
    required init(with service: Service) {
        self.service = service
        self.cancellable = Set<AnyCancellable>()
    }
    
    func list() {
        service.list()
        .map { response in
                response.data.map(ViewModelType.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            
            switch value {
            case .failure(let error):
                self.dataSource = []
                self.state = .error(error)
            case .finished:
                self.state = .complete
            }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.dataSource = value
        })
        .store(in: &cancellable)
    }
}