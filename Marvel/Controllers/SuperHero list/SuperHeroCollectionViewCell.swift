//
//  SuperHeroCollectionViewCell.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit

final class SuperHeroCollectionViewCell: SuperHeroCollectionViewCellBase {
    static public let reuseCellId: String = "SuperHeroCollectionCellID"
    static public let nibName: String = "SuperHeroCollectionViewCell"

    private var viewModel: SuperHeroCellViewModel?


    @IBOutlet private var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override public func setupCell(viewModel: SuperHeroCellViewModel) {
        super.setupCell(viewModel: viewModel)
        self.viewModel = viewModel

        if let name = viewModel.name {
            labelTitle.text = name
        }
    }

}
