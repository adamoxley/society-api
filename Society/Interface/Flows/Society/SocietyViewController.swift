//
//  SocietyViewController.swift
//  Society
//
//  Created by Adam Oxley on 15/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class SocietyViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    private var viewModel: SocietyDetailViewModel
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(viewModel: SocietyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.$dataSource
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { value in
                print(value)
            })
            .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
