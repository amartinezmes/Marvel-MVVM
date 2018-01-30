//
//  SuperHeroTests.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 29/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest
@testable import Marvel

class SuperHeroTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Given the data OK when decode the data then get a SuperHero object
    func testGivenDataOK_whenDecode_thenSuperHero() {
        var superHero: SuperHero?
        let fixture = getFixtureJSON()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            superHero = try? JSONDecoder().decode(SuperHero.self, from: itemData)
        }
        
        XCTAssertTrue(superHero != nil, "Super hero must not be nil")
        XCTAssertTrue(superHero?.id == fixture["id"] as? Int)
        XCTAssertTrue(superHero?.name == fixture["name"] as? String)
        XCTAssertTrue(superHero?.description == fixture["description"] as? String)
        XCTAssertTrue(superHero?.thumbnail != nil)
    }

    
    func testGivenDataWrong_whenDecode_thenNil() {
        var superHero: SuperHero?
        let fixture = getWrongFixtureModel()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            superHero = try? JSONDecoder().decode(SuperHero.self, from: itemData)
        }
        
        XCTAssertNil(superHero, "Super hero must be nil")
    }
    
    func testGivenSuperHero_whenEncode_thenDictionary() {
        guard let superHero: SuperHero = getFixtureModel() else {
            XCTAssertTrue(false, "No fixture data")
            return
        }
        
        guard let encodedData = try? JSONEncoder().encode(superHero),
            let json = try? JSONSerialization.jsonObject(with: encodedData, options: .mutableContainers) as? [String: Any]
        else {
            XCTAssertTrue(false, "No encoded data")
            return
        }
        
        
        XCTAssertTrue(json!["id"] as? Int == superHero.id)
        XCTAssertTrue(json!["name"] as? String == superHero.name)
        XCTAssertTrue(json!["description"] as? String == superHero.description)
        XCTAssertTrue(json!["thumbnail"] != nil)
    }
    
}

//MARK: - Fixtures
extension SuperHeroTests {
    
    /// Gets a fixture model
    ///
    /// - Returns: SuperHero with the fixture data
    fileprivate func getFixtureModel() -> SuperHero? {
        var superHero: SuperHero?

        let fixture = getFixtureJSON()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            superHero = try? JSONDecoder().decode(SuperHero.self, from: itemData)
        }
        
        return superHero
    }
    
    
    /// Gets a JSON with the SuperHero model
    ///
    /// - Returns: Dictionary with key/value
    fileprivate func getFixtureJSON() -> [String: Any] {
        return [
            "id": 12345,
            "name": "Spider test",
            "description": "Description test",
            "thumbnail" : [
                "path": "path test",
                "extension": "jpg"
            ]
        ]
    }
    
    
    /// Gets a wrong JSON of the superHerp model
    ///
    /// - Returns: Dictionary with key/value
    fileprivate func getWrongFixtureModel() -> [String: Any] {
        return [
            "ids": 12345,
            "name": "Spider test",
            "description": "Description test",
            "thumbnail" : [
                "path": "path test",
                "extension": "jpg"
            ]
        ]
    }
    
}
