//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class SuperHero: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }


    private(set) var id: Int?
    var name: String?
    var description: String?
    private(set) var modified: Date?
    var resourceURI: String?
    var thumbnail: Thumbnail?


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(thumbnail, forKey: .thumbnail)
    }
}