//
//  ColumnFlowLayout.swift
//  Society
//
//  Created by Adam Oxley on 06/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    var minColumnWidth: CGFloat
    var columnHeight: CGFloat?
    
    init(minColumnWidth: CGFloat, columnHeight: CGFloat? = nil) {
        self.minColumnWidth = minColumnWidth
        self.columnHeight = columnHeight
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        sectionInsetReference = .fromLayoutMargins
        
        let additionalPadding: CGFloat = 10
        let layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let availableWidth = collectionView.bounds.inset(by: layoutMargins).size.width
        let maxNumberOfColumns = Int(availableWidth / minColumnWidth)
        
        var cellWidth = CGFloat(availableWidth / CGFloat(maxNumberOfColumns)).rounded(.down) - additionalPadding
        
        // The item width must be less than the width of the UICollectionView minus
        if cellWidth > availableWidth {
            cellWidth = availableWidth - additionalPadding
        }
        
        if let columnHeight = columnHeight {
            itemSize = CGSize(width: cellWidth, height: columnHeight)
        } else {
            itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }
}
