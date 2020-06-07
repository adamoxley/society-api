//
//  InterestOnboardingViewController.swift
//  Society
//
//  Created by Adam Oxley on 31/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class InterestOnboardingViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var proceedButton: UIButton!
    
    // MARK: - Children Containers
    private var interestListViewController: InterestListViewController?
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Step 4 of 5"
        
        containerView.isHidden = true
        proceedButton.rounded(by: 5)
        
        setupInterestView()
    }
    
    private func setupInterestView() {
        let service = InterestNetwork()
        let viewModel = InterestListViewModel(with: service)
        interestListViewController = InterestListViewController(viewModel: viewModel)
        
        if let viewController = interestListViewController {
            add(viewController, container: containerView)

            viewController.$selectedInterestItems
                .map({ $0.count >= 3 })
                .assign(to: \.isEnabled, on: proceedButton)
                .store(in: &cancellables)
            
            viewController.$renderedState
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &cancellables)
        }
    }
    
    private func stateValueHandler(_ state: ViewControllerRenderedState) -> Void {
        switch state {
        case .pending:
            proceedButton.isEnabled = false
        case .rendered:
            containerView.setHiddenState(false)
            proceedButton.setHiddenState(false)
        case .failure:
            containerView.setHiddenState(false)
            proceedButton.setHiddenState(true)
        }
    }
}
