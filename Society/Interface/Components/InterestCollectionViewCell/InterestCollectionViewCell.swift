//
//  InterestCollectionViewCell.swift
//  Society
//
//  Created by Adam Oxley on 08/09/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell, ViewModelConfigurable {

    typealias ViewModel = InterestViewModel

    var viewModel: ViewModel?
                
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.rounded(by: 5)
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        imageView.image = UIImage(named: "iPad")
    }
}
