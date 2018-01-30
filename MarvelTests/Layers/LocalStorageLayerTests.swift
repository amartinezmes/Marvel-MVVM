//
//  LocalStorageLayerTests.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 29/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest
@testable import Marvel

class LocalStorageLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Test given a key with the cache empty then exists return false
    func testGivenEmptyCache_whenExistsRequest_thenFalse() {
        XCTAssertFalse(LocalStorageLayer.shared.existsRequest(key: "test"))
    }
    
    /// Test given a key that no exists then exists return false
    func testGivenKeyNotExists_whenExistsRequest_thenFalse() {
        LocalStorageLayer.shared.addRequest(key: "testKey", value: "Value test")
        XCTAssertFalse(LocalStorageLayer.shared.existsRequest(key: "test"))
    }
    
    /// Test given a key that exists then exists return true
    func testGivenKeyExists_whenExistsRequest_thenTrue() {
        LocalStorageLayer.shared.addRequest(key: "testKey", value: "Value test")
        XCTAssertTrue(LocalStorageLayer.shared.existsRequest(key: "testKey"))
    }
    
    
    /// Test filled cache when is purged
    func testGivenFilledCache_whenPurgeCache_thenCacheEmpty() {
        LocalStorageLayer.shared.addRequest(key: "testKey", value: "Value test")
        LocalStorageLayer.shared.addRequest(key: "testKey2", value: "Value test")
        LocalStorageLayer.shared.addRequest(key: "testKey3", value: "Value test")
        XCTAssertTrue(LocalStorageLayer.shared.existsRequest(key: "testKey3"))

        LocalStorageLayer.shared.purgeCache()
        XCTAssertFalse(LocalStorageLayer.shared.existsRequest(key: "testKey3"))
    }

    
    /// Test add request and check that exists
    func testGivenRequest_whenAddRequest_thenRequestExists() {
        LocalStorageLayer.shared.addRequest(key: "testKey", value: "Value test")
        XCTAssertTrue(LocalStorageLayer.shared.existsRequest(key: "testKey"))
    }

    
    /// Given a request when getRequest then return the cacha value
    func testGivenRequest_whenGetRequest_thenRequestValue() {
        LocalStorageLayer.shared.addRequest(key: "testKey", value: "Value test")
        XCTAssertTrue(LocalStorageLayer.shared.getRequest(key: "testKey") as? String == "Value test")
    }
}
