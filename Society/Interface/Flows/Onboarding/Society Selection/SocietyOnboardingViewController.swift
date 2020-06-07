//
//  SocietyOnboardingViewController.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class SocietyOnboardingViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var proceedButton: UIButton!
    
    // MARK: - Children Containers
    private var societyListViewController: SocietyListViewController?
    
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
        
        title = "Step 5 of 5"
        
        containerView.isHidden = false
        proceedButton.rounded(by: 5)
        
        setupInterestView()
    }
    
    private func setupInterestView() {
        let service = SocietyNetwork()
        let viewModel = SocietyListViewModel(with: service)
        societyListViewController = SocietyListViewController(viewModel: viewModel)
        
        if let viewController = societyListViewController {
            add(viewController, container: containerView)
            
            viewController.$renderedState
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &cancellables)
        }
    }
    
    private func stateValueHandler(_ state: ViewControllerRenderedState) -> Void {
        switch state {
        case .pending:
            break
        case .rendered:
            containerView.setHiddenState(false)
            proceedButton.setHiddenState(false)
        case .failure:
            containerView.setHiddenState(false)
            proceedButton.setHiddenState(true)
        }
    }
}
