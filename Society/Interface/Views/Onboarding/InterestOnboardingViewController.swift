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
        
        proceedButton.rounded(by: 5)
        
        setupInterestView()
    }
    
    private func setupInterestView() {
        let service = InterestNetwork()
        let viewModel = InterestListViewModel(with: service)
        interestListViewController = InterestListViewController(viewModel: viewModel)

        if let viewController = interestListViewController {
            add(viewController, frame: containerView.frame)
            
            viewController.$selectedInterestItems
                .map({ $0.count >= 3 })
                .assign(to: \.isEnabled, on: proceedButton)
                .store(in: &cancellables)
        }
    }
}
