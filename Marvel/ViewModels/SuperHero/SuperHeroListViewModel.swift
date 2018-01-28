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

    public func fetch(searchItem: String) {
        interactor.fetchAllHero(by: searchItem) { success, error in
            if success {
                self.numElements.value = self.interactor.heroList.count
            }
        }
    }

    public func fetch() {
        interactor.fetchAllHero(by: nil) { success, error in
            if success {
                self.numElements.value = self.interactor.heroList.count
            }
        }
    }

    public func fetchNextPageIfNeeded(currentItem: Int) -> Bool {
        if (numElements.value - 1) == currentItem && numItemsLoaded < currentItem {
            numItemsLoaded = currentItem
            fetch(searchItem: name.value)
            return true
        }
        return false
    }

    public func reset() {
        interactor.resetList()
        numElements.value = 0
        numItemsLoaded = 0
    }

    public func getCellViewModel(index: Int) -> SuperHeroCellViewModel? {
        if index < interactor.heroList.count {
            let hero: SuperHero = interactor.heroList[index]
            return SuperHeroCellViewModel(name: hero.name, description: hero.description, image: hero.thumbnail)
        }
        return nil
    }


    public func getSuperHero(index: Int) -> SuperHero? {
        if index < interactor.heroList.count {
            return interactor.heroList[index]
        }
        return nil
    }

}