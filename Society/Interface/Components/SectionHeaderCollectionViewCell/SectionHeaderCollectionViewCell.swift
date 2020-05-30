//
//  SectionHeaderCollectionViewCell.swift
//  Society
//
//  Created by Adam Oxley on 25/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

class SectionHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func actionButtonWasTapped(_ sender: UIButton) {
        actionButtonTapped?()
    }
    
    var title: String?
    var actionButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.text = title
    }
}
