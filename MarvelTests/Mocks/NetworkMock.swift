//
//  NetworkMock.swift
//  MarvelTests
//
//  Created by Alex Martinez Mesa on 30/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
@testable import Marvel


final class NetworkLayerMock: NetworkLayer {

}

extension NetworkLayerProtocol where Self: NetworkLayerMock {
    func get(parameters: [String : Any]?, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(self.fakeData(), nil)
    }

    private func fakeData() -> [String: Any] {
        return ["data" : "any"]
    }
}


