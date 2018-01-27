//
// Created by Alex Martinez Mesa on 27/1/18.
// Copyright (c) 2018 Alex Martinez Mesa. All rights reserved.
//

import Foundation

final class SuperHeroDetailViewModel {
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?

    private var interactor: InteractorSuperHeroDetail?


    init(interactor: InteractorSuperHeroDetail) {
        self.interactor = interactor
    }




}