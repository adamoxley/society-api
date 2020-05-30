//
//  UICollectionView+Extension.swift
//  Society
//
//  Created by Adam Oxley on 24/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<C>(_ cellType: C.Type) where C: UICollectionViewCell {
        let name = cellType.identifier
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
        
    func dequeue<M, C>(_ cellType: C.Type, configureFrom viewModel: M, at indexPath: IndexPath) -> C
        where M: ViewModel, C: UICollectionViewCell, C: ViewModelConfigurable, C.ViewModel == M {

        let name = cellType.identifier
        let cell = self.dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as! C
        
        cell.configure(with: viewModel)
        return cell
    }
}
