//
//  GuideCollectionViewCell.swift
//  GuideScreen
//
//  Created by arbenjusufhayati on 11/9/17.
//  Copyright © 2017 HASELT. All rights reserved.
//

import UIKit

@IBDesignable
class GuideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        self.layer.cornerRadius = 1.0
    }
}
