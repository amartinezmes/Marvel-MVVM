//
// Created by Alex Martinez Mesa on 24/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class SuperHero: Codable {
    private(set) var id: Int?
    var name: String?
    var description: String?
    private(set) var modified: Date?



    init(from decoder: Decoder) throws {

    }

    func encode(to encoder: Encoder) throws {

    }
}