//
// Created by Alex Martinez Mesa on 28/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class LocalStorageLayer {
    static let shared: LocalStorageLayer = LocalStorageLayer()

    private var cache: [String: Any] = [String: Any]()

    init() {

    }

    final public func existsRequest(key: String) -> Bool {
        return cache.contains { key, value in
            return key == key
        }
    }

    final public func purgeCache() {
        cache.removeAll()
    }

    final public func addRequest(key: String, value: Any) {
        cache[key] = value
    }

    final public func getRequest(key: String) -> Any? {
        return cache[key]
    }
}