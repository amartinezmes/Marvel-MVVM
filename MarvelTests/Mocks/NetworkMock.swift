//
//  NetworkMock.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 30/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
@testable import Marvel


final class NetworkLayerMock: NetworkLayerProtocol {
    var fakeData: [String: Any] = [String: Any]()

    func get(parameters: [String : Any]?, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(self.fakeData, nil)
    }
}
