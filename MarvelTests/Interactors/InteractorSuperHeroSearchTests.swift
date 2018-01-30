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
        networkMock?.fakeData = fakeData()
        repository = RepositorySuperHero(network: networkMock!, localStorage: LocalStorageLayer.shared)
        interactor = InteractorSuperHeroSearch.init(repository: repository!)
    }
    
    override func tearDown() {
        networkMock = nil
        repository = nil
        interactor = nil
        super.tearDown()
    }

    func testGivenResponse_whenFetchAllHero_thenReturnSuccess() {
        interactor?.fetchAllHero(by: nil, completion: { (success, error) in
            XCTAssertTrue(success)
            XCTAssertTrue(self.interactor?.heroList.count == 2)
        })
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
}
