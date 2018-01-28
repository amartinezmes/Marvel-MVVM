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


    final public func resetList() {
        heroList = [SuperHero]()
    }

}

extension InteractorSuperHeroSearch {
    final public func fetchAllHero(completion: @escaping (_ succed: Bool, _ error: Error?) -> Void) {
        fetchAllHero(by: nil, completion: completion)
    }

    final public func fetchAllHero(by name: String?, completion: @escaping (_ succed: Bool, _ error: Error?) -> Void) {
        RepositorySuperHero.shared.fetchItems(by: name, offset: heroList.count, completion: { heroes, error in
            self.heroList.append(contentsOf: heroes)
            completion(true, error)
        }, pagination: nil)
    }
}
