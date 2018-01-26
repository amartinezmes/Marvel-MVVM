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

    init(interactor: InteractorSuperHeroSearch) {
        self.interactor = interactor
    }

    public func fetch() {
        interactor.fetchAllHero { b, error in
            if b {
                self.numElements.value = self.interactor.heroList.count
            }
        }
    }

    public func fetchNextPage() {
        fetch()
    }

    public func reset() {
        interactor.resetList()
        numElements.value = 0
    }

    public func getCellViewModel(index: Int) -> SuperHeroCellViewModel? {
        if index < interactor.heroList.count {
            let hero: SuperHero = interactor.heroList[index]
            return SuperHeroCellViewModel(name: hero.name, description: hero.description, image: hero.thumbnail)
        }
        return nil
    }

}