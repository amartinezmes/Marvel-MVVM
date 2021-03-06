//
//  String+Extension.swift
//  Marvel
//
//  Created by Alex Martinez Mesa on 25/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

extension String {

    /// Calculate MD5 for the current string
    ///
    /// - Returns: String with the MD5 or nil
    public func MD5() -> String? {
        guard let messageData = self.data(using:.utf8) else {
            return nil
        }

        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }

}
