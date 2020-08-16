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
    func fetch(with pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroType]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository with search parameter
    func fetch(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroType]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository with pagination
    func fetchMore(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        let superhero = SuperheroMock()
        return Promise<[SuperheroType]> { fulfill, reject in fulfill([superhero]) }
    }
    /// Fetch characters from marvel repository
    func refresh(with pageInfo: PageInfo) -> Promise<[SuperheroType]>{
        let superhero = SuperheroMock()
        return Promise<[SuperheroType]> { fulfill, reject in fulfill([superhero]) }
    }
}
