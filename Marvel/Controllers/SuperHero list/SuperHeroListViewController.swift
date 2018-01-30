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
    @IBOutlet private var buttonChangeLayout: UIButton!

    private let disposeBag = DisposeBag()
    private var viewModelList: SuperHeroListViewModel?
    private var numElementsByCol: CGFloat = 3
    private var userHasScrolled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        viewModelList = SuperHeroListViewModel(interactor: InteractorSuperHeroSearch())
        setupRx(viewModel: viewModelList!)
        viewModelList?.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    
    private func setupCollectionView() {
        registerCollectionCells()
        collectionView.isPrefetchingEnabled = false
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
            layout.estimatedItemSize = CGSize.init(width: 2, height: 2)
        }
    }

    private func setupRx(viewModel: SuperHeroListViewModel) {
        viewModel.numElements.asObservable().subscribe(onNext: { e in
            self.collectionView.reloadData()
            self.userHasScrolled = false
        }, onError: { error in

        }, onCompleted: {

        }, onDisposed: {

        }).disposed(by: disposeBag)


        buttonChangeLayout.rx.tap.subscribe(onNext: { void in
            guard let value = self.viewModelList?.layoutRow else {
                return
            }
            self.viewModelList?.layoutRow = !value
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
        }, onError: { error in

        }, onCompleted: {

        }, onDisposed: {

        }).disposed(by: disposeBag)


        searchBar.rx.text.throttle(0.5, scheduler: MainScheduler.instance)
        .subscribe(onNext: { s in
            if let text = s {
                viewModel.name.value = text
            }
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
        if let layoutRow = self.viewModelList?.layoutRow, layoutRow == true {
            return SuperHeroRowCollectionViewCell.reuseCellId
        }
        return SuperHeroCollectionViewCell.reuseCellId
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userHasScrolled = true
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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if userHasScrolled {
            if let fetched = viewModelList?.fetchNextPageIfNeeded(currentItem: indexPath.row), fetched == true {

            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hero = viewModelList?.getSuperHero(index: indexPath.row) else {
            return
        }

        let interactorDetail: InteractorSuperHeroDetail = InteractorSuperHeroDetail(hero: hero)
        let viewControllerDetail: SuperHeroDetailViewController = SuperHeroDetailViewController(interactor: interactorDetail)

        navigationController?.pushViewController(viewControllerDetail, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SuperHeroListViewController:  UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        viewModelList?.reset()
        viewModelList?.fetch()
    }
}
