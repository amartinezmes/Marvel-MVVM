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
        repository = RepositorySuperHero(network: networkMock!, localStorage: LocalStorageLayer.shared)
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func testGivenResponse_whenFetchItems_thenReturnSuperHero() {
        repository?.fetchItems(by: nil, offset: 0, completion: { superHeroes, error in

        }, pagination: { items in  })
    }
    
}
