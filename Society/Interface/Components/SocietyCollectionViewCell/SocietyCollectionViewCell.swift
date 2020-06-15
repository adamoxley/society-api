//
//  SocietyCollectionViewCell.swift
//  Society
//
//  Created by Adam Oxley on 06/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class SocietyCollectionViewCell: UICollectionViewCell, ViewModelConfigurable {

    typealias ViewModel = SocietyListCellViewModel

    private var cancellables = Set<AnyCancellable>()
    var viewModel: ViewModel?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var joinStateButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func joinButtonTapped(_ sender: Any) {
//        viewModel.list()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.rounded(by: 10)
        logoImageView.roundCorner(of: [.topLeft, .bottomLeft], by: 10)
        joinStateButton.rounded(by: 5)
        logoImageView.kf.indicatorType = .activity
    }

    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
        memberCountLabel.text = viewModel.memberCount
        logoImageView.kf.setImage(with: viewModel.imageURL, options: [.transition(.fade(0.3))])
    }
}
