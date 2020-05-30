//
//  RoundedButton.swift
//  Society
//
//  Created by Adam Oxley on 28/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
        clipsToBounds = true
    }
}
