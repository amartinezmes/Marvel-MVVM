//
//  RepositorySuperHero.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class RepositorySuperHero {
    static let shared: RepositorySuperHero = RepositorySuperHero()


    public func fetchItems(offset: Int,
                           completion: @escaping (_ result: [SuperHero],_ error: Error?) -> Void,
                           pagination: ((_ total: Int) -> Void)?) {

        NetworkLayer.shared.get(parameters: nil) { result, error in
            var list: [SuperHero] = [SuperHero]()

            guard let data = result?["results"] as? [[String: Any]] else {
                return
            }

            for item in data {
                if let itemData = try? JSONSerialization.data(withJSONObject: item),
                    let superHero: SuperHero = try? JSONDecoder().decode(SuperHero.self, from: itemData) {
                    list.append(superHero)
                }
            }

            completion(list, error)
        }
    }


    public func fetchItems(by name: String, offset: Int) {

    }

    public func fetchItem(by name: String) {

    }

    public func fetchItem(by id: Int) {

    }

}