//
//  SuperHeroRowCollectionViewCell.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit

class SuperHeroRowCollectionViewCell: UICollectionViewCell {
    static public let reuseCellId: String = "SuperHeroRowID"
    static public let nibName: String = "SuperHeroRowCollectionViewCell"
    
    
    @IBOutlet var labelTest: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

    
}
