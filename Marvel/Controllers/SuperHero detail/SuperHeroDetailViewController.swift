//
//  SuperHeroDetailViewController.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperHeroDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private var imageBackground: UIImageView!
    @IBOutlet private var imageSuperHero: UIImageView! {
        didSet {
            imageSuperHero.layer.cornerRadius = 5
        }
    }

    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var labelDescription: UILabel!

    //MARK: - Properties
    private let downloader: ImageDownloader = ImageDownloader()
    private var viewModelSuperHeroDetail: SuperHeroDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }



    //MARK: - Class
    init(interactor: InteractorSuperHeroDetail?) {
        super.init(nibName: nil, bundle: nil)
        guard let interactor = interactor else {
            return
        }
        viewModelSuperHeroDetail = SuperHeroDetailViewModel(interactor: interactor)
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init(interactor: nil)
    }

    private func downloadImage(url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)

        downloader.download(urlRequest) { response in
            if let image = response.result.value {
                self.imageBackground.image = image
                self.imageSuperHero.image = image
            }
        }
    }

}
