//
// Created by Alex Martinez Mesa on 25/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class SuperHeroCellViewModel {
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?

    init(name: String?, description: String?, image: Thumbnail?) {
        self.name = name
        self.description = description
        self.thumbnail = image
    }
}