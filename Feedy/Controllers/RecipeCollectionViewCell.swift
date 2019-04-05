//
//  RecipeCollectionViewCell.swift
//  Feedy
//
//  Created by jack Maarek on 03/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.image.layer.cornerRadius = 8
        self.image.layer.masksToBounds = true
        
    }
    
}
