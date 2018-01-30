//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkLayerProtocol: class {
    func get(parameters: [String: Any]?, completion: @escaping (_ result: [String: Any]?,_ error: Error?) -> Void)
}


class NetworkLayer {
    /// Singleton
    static let shared: NetworkLayer = NetworkLayer()

    fileprivate static let endPoint: String = "https://gateway.marvel.com/v1/public/characters"

    fileprivate enum defaultParameters: String {
        case timeStamp = "ts"
        case hash
        case apiKey = "apikey"
    }

    private var publicKey: String {
        return "4ab94ec8a75339fc386d8340f7dd2cc9"
        //return "yourKEY"
    }

    private var privateKey: String {
        return "cdf43f2c2dce72cce5a121ea55c74cdd578bffff"
        //return "yourKEY"
    }



    /// Generate the default parameters that always we send with the request
    ///
    /// - Returns: Dictionary with the default parameters
    fileprivate func generateDefaultParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        let ts: String = String(format: "%.0f", Date().timeIntervalSince1970.rounded())

        parameters[defaultParameters.apiKey.rawValue] = publicKey
        parameters[defaultParameters.timeStamp.rawValue] = ts
        parameters[defaultParameters.hash.rawValue] = generateHash(publicKey: publicKey, timeStamp: ts, privateKey: privateKey)
        return parameters
    }


    /// Generate the hash that the server request
    ///
    /// - Parameters:
    ///   - publicKey: Marvel public key
    ///   - timeStamp: Timestamp of the request
    ///   - privateKey: Marvel private key
    /// - Returns: String with the MD5 of the given parameters
    fileprivate func generateHash(publicKey: String, timeStamp: String, privateKey: String) -> String? {
        let stringToMD5: String = timeStamp + privateKey + publicKey
        return stringToMD5.MD5()
    }

}

//MARK: - NetworkLayerProtocol
extension NetworkLayer: NetworkLayerProtocol {

    /// Request to the server with a get
    ///
    /// - Parameters:
    ///   - parameters: Parameters to send with the request
    ///   - completion: completion block with the result or the error
    func get(parameters: [String: Any]?, completion: @escaping (_ result: [String: Any]?,_ error: Error?) -> Void) {
        var params: Parameters = generateDefaultParameters()
        if let parametersFromRequest = parameters {
            params.merge(parametersFromRequest) { (any: Any, any1: Any) -> Any in
                return any
            }
        }

        Alamofire.request(NetworkLayer.endPoint, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
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
