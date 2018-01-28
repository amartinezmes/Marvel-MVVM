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

        fetchItems(by: nil, offset: offset, completion: completion, pagination: pagination)
    }


    public func fetchItems(by name: String?,
                           offset: Int,
                           completion: @escaping (_ result: [SuperHero],_ error: Error?) -> Void,
                           pagination: ((_ total: Int) -> Void)?) {
        var parameters: [String: Any] = [String: Any]()

        if let searchString = name, !searchString.isEmpty {
            parameters["nameStartsWith"] = searchString
        }
        parameters["offset"] = offset

        if let sourceData = LocalStorageLayer.shared.getRequest(key: parameters.description),
           let data = sourceData as? [[String: Any]] {
            print("USE CACHE")
            let list: [SuperHero] = self.convertData(data: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                completion(list, nil)
            }
        } else {
            print("NETWORK")
            NetworkLayer.shared.get(parameters: parameters) { result, error in
                guard let data = result?["results"] as? [[String: Any]] else {
                    return
                }

                LocalStorageLayer.shared.addRequest(key: parameters.description, value: data)
                let list: [SuperHero] = self.convertData(data: data)
                completion(list, error)
            }
        }
    }

    public func fetchItem(by name: String,
                          completion: @escaping (_ result: SuperHero,_ error: Error?) -> Void) {


    }

    public func fetchItem(by id: Int,
                          completion: @escaping (_ result: SuperHero,_ error: Error?) -> Void) {


    }

    private func convertData(data: [[String: Any]]) -> [SuperHero] {
        var list: [SuperHero] = [SuperHero]()

        for item in data {
            if let itemData = try? JSONSerialization.data(withJSONObject: item),
               let superHero: SuperHero = try? JSONDecoder().decode(SuperHero.self, from: itemData) {
                list.append(superHero)
            }
        }

        return list
    }

}