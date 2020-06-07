//
//  InterestCollectionViewCell.swift
//  Society
//
//  Created by Adam Oxley on 08/09/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit
import Kingfisher

class InterestCollectionViewCell: UICollectionViewCell, ViewModelConfigurable {

    typealias ViewModel = InterestViewModel

    var viewModel: ViewModel?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                overlayView.layer.borderWidth = 3
                overlayView.isHidden = false
            } else {
                overlayView.layer.borderWidth = 0
                overlayView.isHidden = true
            }
        }
    }
                
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.rounded(by: 15)
        overlayView.rounded(by: 15)
        overlayView.layer.masksToBounds = true
        overlayView.backgroundColor = UIColor.asset(.highlightState)
        overlayView.layer.borderColor = UIColor.asset(.borderHighlightState).cgColor
        imageView.kf.indicatorType = .activity
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.name
        imageView.kf.setImage(with: viewModel.imageURL, options: [.transition(.fade(0.3))])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            overlayView.layer.borderColor = UIColor.asset(.borderHighlightState).cgColor
        }
    }
}
