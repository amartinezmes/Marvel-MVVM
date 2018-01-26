//
//  SuperHeroListViewController.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SuperHeroListViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var searchBar: UISearchBar!

    private let disposeBag = DisposeBag()
    private var viewModelList: SuperHeroListViewModel?
    private var numElementsByCol: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModelList = SuperHeroListViewModel(interactor: InteractorSuperHeroSearch())
        setupRx(viewModel: viewModelList!)
        viewModelList?.fetch()
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

    private func setupRx(viewModel: SuperHeroListViewModel) {
        viewModel.numElements.asObservable().subscribe(onNext: { e in
            self.collectionView.reloadData()
         }, onError: { error in

          }, onCompleted: {

        }, onDisposed: {

        }).disposed(by: disposeBag)
    }

    @objc private func onRefresh() {
        collectionView.refreshControl?.endRefreshing()
        viewModelList?.reset()
        viewModelList?.fetch()
    }

    fileprivate func getCellId() -> String {
        return SuperHeroCollectionViewCell.reuseCellId
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SuperHeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numElements = viewModelList?.numElements else {
            return 0
        }
        return numElements.value
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getCellId(), for: indexPath) as! SuperHeroCollectionViewCellBase

        if let cellViewModel = viewModelList?.getCellViewModel(index: indexPath.row) {
            cell.setupCell(viewModel: cellViewModel)
        }

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SuperHeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = (collectionView.frame.width) / 4
        let rightInset = leftInset

        //return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        return UIEdgeInsets.zero
    }
}