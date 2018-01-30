//
//  InteractorSuperHeroSearch.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class InteractorSuperHeroSearch {
    private let repository: RepositorySuperHero

    private(set) var heroList: [SuperHero]

    init(repository: RepositorySuperHero = RepositorySuperHero.shared) {
        heroList = [SuperHero]()
        self.repository = repository
    }


    /// Clear internal superhero list
    final public func resetList() {
        heroList = [SuperHero]()
    }

}

extension InteractorSuperHeroSearch {
    
    
    /// Fetch all hero without filters
    ///
    /// - Parameter completion: Completion block
    final public func fetchAllHero(completion: @escaping (_ succed: Bool, _ error: Error?) -> Void) {
        fetchAllHero(by: nil, completion: completion)
    }

    
    /// Fetch all Hero using a text filter if it is informed
    ///
    /// - Parameters:
    ///   - name: Name to search
    ///   - completion: Completion block
    final public func fetchAllHero(by name: String?, completion: @escaping (_ succed: Bool, _ error: Error?) -> Void) {
        repository.fetchItems(by: name, offset: heroList.count, completion: { heroes, error in
            self.heroList.append(contentsOf: heroes)
            completion(true, error)
        }, pagination: nil)
    }
}
