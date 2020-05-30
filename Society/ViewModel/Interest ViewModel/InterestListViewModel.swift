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
    
    typealias ViewModel = InterestViewModel
    typealias Service = InterestNetworkable
    
    // Service properties
    var service: Service
    private var cancellable = [AnyCancellable]()
    
    // Data properties
    @Published var dataSource: [InterestViewModel] = []
    
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
                case .failure:
                    self.dataSource = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] interest in
                guard let self = self else { return }
                self.dataSource = interest
            })
            .store(in: &cancellable)
    }
}
