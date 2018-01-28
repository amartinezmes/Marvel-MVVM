//
// Created by Alex Martinez Mesa on 26/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class SuperHeroCollectionViewCellBase: UICollectionViewCell {
    private let downloader: ImageDownloader = ImageDownloader()

    @IBOutlet private var image: UIImageView! {
        didSet {
            image.layer.cornerRadius = 5
            image.clipsToBounds = true
        }
    }

    public func setupCell(viewModel: SuperHeroCellViewModel) {
        if let path = viewModel.thumbnail?.path,
           let fileExtension = viewModel.thumbnail?.fileExtension {
            downloadImage(url: path + "." + fileExtension)
        }
    }

    private func downloadImage(url: String) {

        let urlRequest = URLRequest(url: URL(string: url)!)

        downloader.download(urlRequest) { response in
            if let image = response.result.value {
                self.image.image = image
            }
        }
    }

}