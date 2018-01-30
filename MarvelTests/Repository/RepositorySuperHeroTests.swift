//
//  RepositorySuperHeroTests.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 30/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest
@testable import Marvel

class RepositorySuperHeroTests: XCTestCase {
    var repository: RepositorySuperHero?
    var networkMock: NetworkLayerMock?
    
    override func setUp() {
        super.setUp()
        networkMock = NetworkLayerMock()
        networkMock?.fakeData = fakeData()
        repository = RepositorySuperHero(network: networkMock!, localStorage: LocalStorageLayer.shared)
    }
    
    override func tearDown() {
        networkMock = nil
        repository = nil
        super.tearDown()
    }

    
    /// Test fetch items using network response
    func testGivenNetworkResponse_whenFetchItems_thenReturnSuperHero() {
        repository?.fetchItems(by: nil, offset: 0, completion: { superHeroes, error in
            XCTAssertTrue(superHeroes.count == 2)
            XCTAssertTrue(LocalStorageLayer.shared.existsRequest(key: "[\"offset\": 0]"))
        }, pagination: { items in  })
    }

    
    /// Test fetch items using cache
    func testGivenCacheResponse_whenFetchItems_thenReturnSuperHero() {
        LocalStorageLayer.shared.addRequest(key: "[\"offset\": 0]", value: fakeCacheData())
        repository?.fetchItems(by: nil, offset: 0, completion: { superHeroes, error in
            XCTAssertTrue(superHeroes.count == 1)
        }, pagination: { items in  })
    }


    private func fakeData() -> [String: Any] {
        return ["results" : [
            ["id": 1,
            "name" : "test1",
            "description" : "description1",
            "thumbnail": [
                "path":"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                "extension":"jpg"
            ]],
            ["id": 2,
            "name" : "test2",
            "description" : "description2",
            "thumbnail": [
                "path":"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                "extension":"jpg"
            ]]
            ]
        ]
    }
    
    private func fakeCacheData() -> [[String: Any]] {
        return [
            ["id": 1,
             "name" : "test1",
             "description" : "description1",
             "thumbnail": [
                "path":"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                "extension":"jpg"
                ]]
            ]
    }
    
}
