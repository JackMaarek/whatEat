//
//  FoodControllerCollectionViewCell.swift
//  Feedy
//
//  Created by jack Maarek on 02/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class FoodControllerCollectionViewCell: knDraggableCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.image.layer.cornerRadius = 8
        self.image.layer.masksToBounds = true
        
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.5
        self.containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.containerView.layer.cornerRadius = 8
    }
    
}
