//
//  InteractorSuperHeroSearch.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class InteractorSuperHeroSearch {
    private(set) var heroList: [SuperHero]

    init() {
        heroList = [SuperHero]()
    }


    public func resetList() {
        heroList = [SuperHero]()
    }

}

extension InteractorSuperHeroSearch {
    public func fetchAllHero(completion: @escaping (_ succed: Bool, _ error: Error?) -> Void) {
        RepositorySuperHero.shared.fetchItems(offset: heroList.count , completion: { heroes, error in
            self.heroList.append(contentsOf: heroes)
            completion(true, error)
        }, pagination: nil)
    }

    public func fetchAllHero(by name: String) {

    }
}