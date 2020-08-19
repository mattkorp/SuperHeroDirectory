//
//  MarvelRepositoryMock.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/19/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation
@testable import SuperHeroDirectory

struct MarvelRepositoryMock: MarvelRepositoryProtocol {
    func get(named: String?, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        Promise<[SuperheroType]> { fulfill, reject in
            fulfill((1...pageInfo.limit).map { _ -> SuperheroType in
                Superhero(name: "fixture name", description: "fixture description", thumbnail: Image(path: nil, format: nil))
            })
        }
    }
}
