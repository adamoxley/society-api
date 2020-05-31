//
//  InterestListViewModel.swift
//  Society
//
//  Created by Adam Oxley on 27/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

enum InterestViewModelState {
    case loading
    case complete
    case error(HTTPError)
}

class InterestListViewModel {
    
    typealias ViewModel = InterestViewModel
    typealias Service = InterestNetworkable
    
    // Service properties
    var service: Service
    private var cancellable = Set<AnyCancellable>()
    
    // Data properties
    @Published private(set) var dataSource: [InterestViewModel] = []
    @Published private(set) var state: InterestViewModelState = .loading
    
    required init(with service: Service) {
        self.service = service
    }
    
    func fetch() {
        service.fetch()
            .map { response in
                response.data.map(InterestViewModel.init)
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
            }, receiveValue: { [weak self] interest in
                guard let self = self else { return }
                
                self.dataSource = interest
            })
            .store(in: &cancellable)
    }
}
