//
//  InteractorSuperHeroSearchTests.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 30/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest
@testable import Marvel

class InteractorSuperHeroSearchTests: XCTestCase {
    var repository: RepositorySuperHero?
    var interactor: InteractorSuperHeroSearch?
    var networkMock: NetworkLayerMock?


    override func setUp() {
        super.setUp()
        networkMock = NetworkLayerMock()
        repository = RepositorySuperHero(network: networkMock!, localStorage: LocalStorageLayer.shared)
        interactor = InteractorSuperHeroSearch.init(repository: repository!)
    }
    
    override func tearDown() {
        networkMock = nil
        repository = nil
        interactor = nil
        super.tearDown()
    }



}
