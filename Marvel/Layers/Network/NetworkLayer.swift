//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkLayer {
    static let shared: NetworkLayer = NetworkLayer()





}

//MARK: - Defaults parameters
extension NetworkLayer {

    fileprivate enum defaultParameters: String {
        case timeStamp = "ts"
        case hash
        case apiKey
    }


    fileprivate func generateDefaultParameters() -> [String: Any] {

        return ["ts": 323232]
    }

}