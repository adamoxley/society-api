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
        guard let viewModel = viewModel else { return }
        
        switch viewModel.joinState {
        case .join: viewModel.join()
        case .joined, .pending: viewModel.leave()
        }
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
        
        viewModel.$joinState
            .receive(on: DispatchQueue.main)
            .sink() { [self] value in
                UIView.animate(withDuration: 0.3, animations: {
                    switch value {
                    case .join:
                        joinStateButton.setTitle("Join", for: .normal)
                        joinStateButton.backgroundColor = UIColor.asset(.action)
                    case .joined:
                        joinStateButton.setTitle("Leave", for: .normal)
                        joinStateButton.backgroundColor = UIColor.asset(.destructive)
                    case .pending:
                        joinStateButton.setTitle("Pending", for: .normal)
                        joinStateButton.backgroundColor = UIColor.asset(.action)
                    }
                })
            }
            .store(in: &cancellables)
    }
}
