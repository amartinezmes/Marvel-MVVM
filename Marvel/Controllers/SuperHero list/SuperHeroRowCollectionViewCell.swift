//
//  SuperHeroRowCollectionViewCell.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit
import AlamofireImage

final class SuperHeroRowCollectionViewCell: SuperHeroCollectionViewCellBase {
    static public let reuseCellId: String = "SuperHeroRowID"
    static public let nibName: String = "SuperHeroRowCollectionViewCell"

    private var viewModel: SuperHeroCellViewModel?

    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override public func setupCell(viewModel: SuperHeroCellViewModel) {
        super.setupCell(viewModel: viewModel)
        self.viewModel = viewModel

        if let name = viewModel.name {
            labelName.text = name
            labelName.accessibilityIdentifier = name
        }

        if let description = viewModel.description {
            labelDescription.text = description
        }
    }
}
