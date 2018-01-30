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

    private let network: NetworkLayerProtocol
    private let localStorage: LocalStorageLayer

    init(network: NetworkLayerProtocol = NetworkLayer.shared, localStorage: LocalStorageLayer = LocalStorageLayer.shared) {
        self.network = network
        self.localStorage = localStorage
    }
    
    final public func fetchItems(offset: Int,
                           completion: @escaping (_ result: [SuperHero],_ error: Error?) -> Void,
                           pagination: ((_ total: Int) -> Void)?) {

        fetchItems(by: nil, offset: offset, completion: completion, pagination: pagination)
    }


    final public func fetchItems(by name: String?,
                           offset: Int,
                           completion: @escaping (_ result: [SuperHero],_ error: Error?) -> Void,
                           pagination: ((_ total: Int) -> Void)?) {
        var parameters: [String: Any] = [String: Any]()

        if let searchString = name, !searchString.isEmpty {
            parameters["nameStartsWith"] = searchString
        }
        parameters["offset"] = offset

        if let sourceData = localStorage.getRequest(key: parameters.description),
           let data = sourceData as? [[String: Any]] {
            print("USE CACHE")
            let list: [SuperHero] = self.convertData(data: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                completion(list, nil)
            }
        } else {
            print("NETWORK")
            network.get(parameters: parameters) { result, error in
                guard let data = result?["results"] as? [[String: Any]] else {
                    return
                }

                self.localStorage.addRequest(key: parameters.description, value: data)
                let list: [SuperHero] = self.convertData(data: data)
                completion(list, error)
            }
        }
    }

    
    /// Fetch item using the hero name
    ///
    /// - Parameters:
    ///   - name: Name to search
    ///   - completion: Completion block with the super hero and the error
    final public func fetchItem(by name: String,
                          completion: @escaping (_ result: SuperHero?,_ error: Error?) -> Void) {


    }

    
    /// Fetch an item using the object Id
    ///
    /// - Parameters:
    ///   - id: Id to fetch
    ///   - completion: Completion block with the superHero and the error
    final public func fetchItem(by id: Int,
                          completion: @escaping (_ result: SuperHero?,_ error: Error?) -> Void) {


    }

    
    /// Convert the given array of dictionary to a SuperHero array
    ///
    /// - Parameter data: Data to convert
    /// - Returns: Array of SuperHero
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
