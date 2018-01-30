//
// Created by Alex Martinez Mesa on 27/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class InteractorSuperHeroDetail {
    private let repository: RepositorySuperHero

    private(set) var hero: SuperHero?


    init(repository: RepositorySuperHero = RepositorySuperHero.shared) {
        self.repository = repository
    }

    init(hero: SuperHero) {
        self.hero = hero
        self.repository = RepositorySuperHero.shared
    }


    public func fetchHero(by id: Int) {

    }

    public func fetchHero(by name: String) {

    }

}