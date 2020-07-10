//
//  SocietyDetailViewModel.swift
//  Society
//
//  Created by Adam Oxley on 10/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

class SocietyDetailViewModel {
    
    typealias ViewModelType = SocietyViewModel
    typealias ErrorType = HTTPError
    typealias Service = SocietyNetwork
    
    private var id: UUID
    private var service: SocietyNetwork
    private var cancellable: Set<AnyCancellable>
    
    @Published var dataSource: ViewModelType?
    @Published var state: ViewModelLoadingState<HTTPError> = .loading
    
    required init(with service: Service, id: UUID) {
        self.service = service
        self.id = id
        self.cancellable = Set<AnyCancellable>()
        
        fetch()
    }
    
    // MARK: - Methods
    func fetch() {
        service.fetch(id: id)
        .map(SocietyViewModel.init)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.dataSource = nil
                self.state = .error(.badRequest)
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
