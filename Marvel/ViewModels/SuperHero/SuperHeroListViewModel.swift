//
// Created by Alex Martinez Mesa on 25/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import RxSwift

final class SuperHeroListViewModel {
    private let disposeBag = DisposeBag()
    private let interactor: InteractorSuperHeroSearch

    public var name = Variable<String>("")
    public var numElements = Variable<Int>(0)

    public var layoutRow: Bool = true

    private var numItemsLoaded:Int = 0

    init(interactor: InteractorSuperHeroSearch) {
        self.interactor = interactor

         name.asObservable().subscribe(onNext: { s in
             if !s.isEmpty {
                 self.reset()
                 self.fetch(searchItem: s)
             }
         }, onError: { error in

         }, onCompleted: {

         }, onDisposed: {

         }).disposed(by: disposeBag)

    }

    
    /// Fetch the data with the given search term
    ///
    /// - Parameter searchItem: String with the text to search
    final public func fetch(searchItem: String) {
        interactor.fetchAllHero(by: searchItem) { success, error in
            if success {
                self.numElements.value = self.interactor.heroList.count
            }
        }
    }

    
    /// Fetch all hero
    final public func fetch() {
        interactor.fetchAllHero(by: nil) { success, error in
            if success {
                self.numElements.value = self.interactor.heroList.count
            }
        }
    }

    
    /// Fetch the next page if it's needed
    ///
    /// - Parameter currentItem: The current displayed item
    /// - Returns: True if a new page is fetched, otherwise false
    final public func fetchNextPageIfNeeded(currentItem: Int) -> Bool {
        if (numElements.value - 1) == currentItem && numItemsLoaded < currentItem {
            numItemsLoaded = currentItem
            fetch(searchItem: name.value)
            return true
        }
        return false
    }

    
    /// Clear the view status
    final public func reset() {
        interactor.resetList()
        numElements.value = 0
        numItemsLoaded = 0
    }

    
    /// Obtain a cell view model for the given index
    ///
    /// - Parameter index: Index selected
    /// - Returns: Cell view model
    final public func getCellViewModel(index: Int) -> SuperHeroCellViewModel? {
        if index < interactor.heroList.count {
            let hero: SuperHero = interactor.heroList[index]
            return SuperHeroCellViewModel(name: hero.name, description: hero.description, image: hero.thumbnail)
        }
        return nil
    }


    /// Get a super hero by index
    ///
    /// - Parameter index: Index selected
    /// - Returns: SuperHero for the given index
    final public func getSuperHero(index: Int) -> SuperHero? {
        if index < interactor.heroList.count {
            return interactor.heroList[index]
        }
        return nil
    }

}
