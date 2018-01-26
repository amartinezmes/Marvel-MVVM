//
// Created by Alex Martinez Mesa on 26/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class Thumbnail: Codable {
    var path: String?
    var fileExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        fileExtension = try values.decode(String.self, forKey: .fileExtension)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(fileExtension, forKey: .fileExtension)
    }

}
