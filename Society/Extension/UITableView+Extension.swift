//
//  UITableView+Extension.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<C>(_ cellType: C.Type) where C: UITableViewHeaderFooterView {
        let name = cellType.identifier
        self.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
    }
    
    func register<C>(_ cellType: C.Type) where C: UITableViewCell {
        let name = cellType.identifier
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func dequeue<M, C>(_ cellType: C.Type, configureFrom viewModel: M, at indexPath: IndexPath) -> C
        where M: ViewModel, C: UITableViewCell, C: ViewModelConfigurable, C.ViewModel == M {
            let name = cellType.identifier
            let cell = self.dequeueReusableCell(withIdentifier: name, for: indexPath) as! C
            
            cell.configure(with: viewModel)
            return cell
    }
    
    func dequeueReusableHeaderFooterView<C>(_ cellType: C.Type) -> C where C: UITableViewHeaderFooterView {
        let name = cellType.identifier
        let cell = self.dequeueReusableHeaderFooterView(withIdentifier: name) as! C
        return cell
    }
}
