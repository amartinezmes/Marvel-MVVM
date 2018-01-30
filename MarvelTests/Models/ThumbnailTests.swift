//
//  ThumbnailTests.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 29/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest
@testable import Marvel

class ThumbnailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// Given the data OK when decode the data then get a Thumbnail object
    func testGivenDataOK_whenDecode_thenThumbnail() {
        var thumbnail: Thumbnail?
        let fixture = getFixtureJSON()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            thumbnail = try? JSONDecoder().decode(Thumbnail.self, from: itemData)
        }
        
        XCTAssertTrue(thumbnail != nil, "thumbnail must not be nil")
        XCTAssertTrue(thumbnail?.path == fixture["path"] as? String)
        XCTAssertTrue(thumbnail?.fileExtension == fixture["extension"] as? String)
    }
    
    func testGivenDataWrong_whenDecode_thenNil() {
        var thumbnail: Thumbnail?
        let fixture = getWrongFixtureModel()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            thumbnail = try? JSONDecoder().decode(Thumbnail.self, from: itemData)
        }
        
        XCTAssertNil(thumbnail, "Thumbnail must be nil")
    }
    
    func testGivenThumbnail_whenEncode_thenDictionary() {
        guard let thumbnail: Thumbnail = getFixtureModel() else {
            XCTAssertTrue(false, "No fixture data")
            return
        }
        
        guard let encodedData = try? JSONEncoder().encode(thumbnail),
            let json = try? JSONSerialization.jsonObject(with: encodedData, options: .mutableContainers) as? [String: Any]
            else {
                XCTAssertTrue(false, "No encoded data")
                return
        }
        
        
        XCTAssertTrue(json!["path"] as? String == thumbnail.path)
        XCTAssertTrue(json!["extension"] as? String == thumbnail.fileExtension)
    }
    
}

//MARK: - Fixtures
extension ThumbnailTests {
    
    fileprivate func getFixtureModel() -> Thumbnail? {
        var thumbnail: Thumbnail?
        let fixture = getFixtureJSON()
        if let itemData = try? JSONSerialization.data(withJSONObject: fixture) {
            thumbnail = try? JSONDecoder().decode(Thumbnail.self, from: itemData)
        }
        
        return thumbnail
    }
    
    fileprivate func getFixtureJSON() -> [String: Any] {
        return [
            "path": "path test",
            "extension": "jpg"
        ]
    }
    
    fileprivate func getWrongFixtureModel() -> [String: Any] {
        return [
            "paths": "path test",
            "extension": "jpg"
        ]
    }
    
}
