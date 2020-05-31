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
    private var selectedState: Bool = false
                
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.rounded(by: 15)
        overlayView.rounded(by: 15)
        overlayView.layer.masksToBounds = true
        overlayView.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        imageView.image = UIImage(named: "iPad")
    }
    
    func setSelectedState() {
        selectedState.toggle()
        
        if selectedState {
            overlayView.layer.borderWidth = 3
            overlayView.isHidden = false
        } else {
            overlayView.layer.borderWidth = 0
            overlayView.isHidden = true
        }
        
    }
}
