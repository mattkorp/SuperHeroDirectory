//
//  GetSuperheroUseCaseStub.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Foundation

struct GetSuperheroUseCaseStub: GetSuperheroUseCaseProtocol {
    /// Fetch characters from marvel repository with pagination
    mutating func fetch() -> Promise<[SuperheroProtocol]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroProtocol]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository with search parameter
    mutating func fetch(startsWith: String) -> Promise<[SuperheroProtocol]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroProtocol]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository with pagination
    mutating func fetchMore(startsWith: String) -> Promise<[SuperheroProtocol]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroProtocol]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository
    mutating func refresh() -> Promise<[SuperheroProtocol]>{
        let superhero = SuperheroMock()
        return Promise<[SuperheroProtocol]> { fulfill, reject in fulfill([superhero]) }
    }
}
