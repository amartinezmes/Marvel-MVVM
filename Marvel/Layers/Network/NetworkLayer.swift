//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkLayer {
    static let shared: NetworkLayer = NetworkLayer()

    fileprivate static let endPoint: String = "https://gateway.marvel.com/v1/public/characters"


    public func get(parameters: [String: Any]?, completion: @escaping (_ result: [String: Any]?,_ error: Error?) -> Void) {

        Alamofire.request(NetworkLayer.endPoint, method: .get, parameters: generateDefaultParameters(), encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                guard let json = response.result.value as? [String: Any],
                      let data = json["data"] as? [String: Any] else {
                    completion(nil, nil)
                    return
                }
                completion(data, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}


//MARK: - Defaults parameters
extension NetworkLayer {
    private var publicKey: String {
        return "4ab94ec8a75339fc386d8340f7dd2cc9"
        //return "yourKEY"
    }

    private var privateKey: String {
        return "cdf43f2c2dce72cce5a121ea55c74cdd578bffff"
        //return "yourKEY"
    }


    fileprivate enum defaultParameters: String {
        case timeStamp = "ts"
        case hash
        case apiKey = "apikey"
    }


    fileprivate func generateDefaultParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]

        parameters[defaultParameters.apiKey.rawValue] = "4ab94ec8a75339fc386d8340f7dd2cc9"
        parameters[defaultParameters.timeStamp.rawValue] = 1516884892
        parameters[defaultParameters.hash.rawValue] = "d03ab1702ebedfce3b5e806aa347ebec"
        return parameters
    }

    fileprivate func generateHash(publicKey: String, timeStamp: String, privateKey: String) -> String? {

        return nil
    }

}
