//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class NetworkLayer {
    static let shared: NetworkLayer = NetworkLayer()





}

//MARK: - Defaults parameters
extension NetworkLayer {

    fileprivate func generateDefaultParameters() -> [String: Any] {

        return ["ts": 323232]
    }

}