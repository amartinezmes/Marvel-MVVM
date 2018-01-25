//
//  SuperHeroListViewController.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit

final class SuperHeroListViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var searchBar: UISearchBar!

    private var numElementsByCol: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    private func setupCollectionView() {
        registerCollectionCells()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        calculateLayoutCollectionItem()

    }


    private func registerCollectionCells() {
        collectionView.register(UINib(nibName: SuperHeroRowCollectionViewCell.nibName, bundle: nil),
                forCellWithReuseIdentifier: SuperHeroRowCollectionViewCell.reuseCellId)

        collectionView.register(UINib(nibName: SuperHeroCollectionViewCell.nibName, bundle: nil),
                forCellWithReuseIdentifier: SuperHeroCollectionViewCell.reuseCellId)

    }

    private func calculateLayoutCollectionItem() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize.init(width: 1, height: 1)
        }
    }


    @objc private func onRefresh() {
        collectionView.refreshControl?.endRefreshing()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SuperHeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuperHeroRowCollectionViewCell.reuseCellId, for: indexPath) as! SuperHeroRowCollectionViewCell

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuperHeroCollectionViewCell.reuseCellId, for: indexPath) as! SuperHeroCollectionViewCell

        if indexPath.row == 1 {
            //cell.labelTest.text = "Esto es un test para ver qiue pasa si esto es mjy largo"
        }

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SuperHeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = (collectionView.frame.width) / 5
        let rightInset = leftInset

        //return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        return UIEdgeInsets.zero
    }
}