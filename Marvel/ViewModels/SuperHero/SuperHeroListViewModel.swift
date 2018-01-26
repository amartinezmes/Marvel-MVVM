//
// Created by Alex Martinez Mesa on 25/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import RxSwift

final class SuperHeroListViewModel {
    private let interactor: InteractorSuperHeroSearch
    public var numElements: Int? = 0

    init(interactor: InteractorSuperHeroSearch) {
        self.interactor = interactor
    }

    public func fetch() {
        interactor.fetchAllHero { b, error in
            if b {
                self.numElements = self.interactor.heroList.count
            }
        }
    }

    public func fetchNextPage() {

    }

    public func reset() {

    }

    public func getCellViewModel(index: Int) {

    }

}