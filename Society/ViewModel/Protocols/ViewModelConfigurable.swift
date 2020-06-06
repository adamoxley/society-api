//
//  ViewModelConfigurable.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    
    associatedtype ViewModel
    
    var viewModel: ViewModel? { get }
    
    func configure(with viewModel: ViewModel)
}

