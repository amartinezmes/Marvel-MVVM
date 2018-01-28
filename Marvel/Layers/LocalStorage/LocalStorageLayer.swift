//
// Created by Alex Martinez Mesa on 28/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class LocalStorageLayer {
    
    /// Singleton
    static let shared: LocalStorageLayer = LocalStorageLayer()

    private var cache: [String: Any] = [String: Any]()

    init() {

    }

    
    /// Check if the key exists on the cache
    ///
    /// - Parameter key: String key to search
    /// - Returns: True if the key exists, otherwise false
    final public func existsRequest(key: String) -> Bool {
        return cache.contains { key, value in
            return key == key
        }
    }

    
    /// Remove all the cache
    final public func purgeCache() {
        cache.removeAll()
    }

    
    /// Add a request to the cache. If exists the value is updated.
    ///
    /// - Parameters:
    ///   - key: String with the key
    ///   - value: Value to save on the cache
    final public func addRequest(key: String, value: Any) {
        cache[key] = value
    }

    
    /// Get the request saved on the cache
    ///
    /// - Parameter key: String with the key to search
    /// - Returns: Request value saved on the cache
    final public func getRequest(key: String) -> Any? {
        return cache[key]
    }
}
