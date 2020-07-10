//
//  SocietyListCellViewModel.swift
//  Society
//
//  Created by Adam Oxley on 14/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation
import Combine

class SocietyListCellViewModel: ViewModel {
    
    typealias Model = Society
    
    @Published var state: ViewModelLoadingState<HTTPError> = .pending
    @Published var joinState: Society.JoinState
    
    private var service: SocietyNetwork
    private var cancellable: Set<AnyCancellable>
    internal var model: Model
    
    var id: UUID {
        return model.id
    }
    
    var name: String {
        return model.name
    }
    
    var memberCount: String {
        return "\(model.memberCount) Members"
    }
    
    var imageURL: URL {
        guard let imageURL = model.imageURL else {
            return URL(fileReferenceLiteralResourceName: "iPad")
        }
        
        return imageURL
    }
    
    required init(model: Model) {
        self.service = SocietyNetwork()
        self.cancellable = Set<AnyCancellable>()
        
        self.model = model
        
        // Set the initial models join state
        joinState = model.state
    }
    
    
    // MARK: - Join State Network
    
    func join() {
        let result = service.join(id: id)
        handleJoinStateResult(result)
    }
    
    func leave() {
        let result = service.leave(id: id)
        handleJoinStateResult(result)
    }
    
    private func handleJoinStateResult(_ result: AnyPublisher<SocietyJoinStateResponse, SocietyNetwork.ErrorType>) {
        result
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.state = .error(.badRequest)
            case .finished:
                self.state = .complete
            }
        }, receiveValue: { [weak self] value in
            guard let self = self else { return }
            self.joinState = value.state
        })
        .store(in: &cancellable)
    }
}

extension SocietyListCellViewModel: Hashable {
    static func == (lhs: SocietyListCellViewModel, rhs: SocietyListCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
