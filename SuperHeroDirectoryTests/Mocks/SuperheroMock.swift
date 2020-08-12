//
//  SuperheroMock.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Foundation

struct SuperheroMock: SuperheroProtocol {
    var name: String? { "Fixture name" }
    var description: String? { "Fixture description" }
    var thumbnail: Image { Image(path: nil, format: nil) }
}
