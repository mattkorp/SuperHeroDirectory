//
//  GetSuperheroUseCase.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol GetSuperheroUseCaseProtocol {
    /// Fetch characters from marvel repository with pagination
    mutating func fetch() -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository with search parameter
    mutating func fetch(startsWith: String) -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository with pagination
    mutating func fetchMore(startsWith: String) -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository
    mutating func refresh() -> Promise<[SuperheroType]>
}

struct GetSuperheroUseCase {

    private let marvelRepository: MarvelRepositoryProtocol
    private var offset: Int = 0

    init(marvelRepository: MarvelRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
}

extension GetSuperheroUseCase: GetSuperheroUseCaseProtocol {
    
    mutating func fetch() -> Promise<[SuperheroType]> {
        setPaginationOffset(offset + Constants.limit)
        return marvelRepository.get(named: nil, offset: offset, limit: Constants.limit)
    }
    
    mutating func fetch(startsWith: String) -> Promise<[SuperheroType]> {
        setPaginationOffset(0)
        return marvelRepository.get(named: startsWith, offset: offset, limit: Constants.limit)
    }
    
    mutating func fetchMore(startsWith: String) -> Promise<[SuperheroType]> {
        setPaginationOffset(offset + Constants.limit)
        return marvelRepository.get(named: startsWith, offset: offset, limit: Constants.limit)
    }
    
    mutating func refresh() -> Promise<[SuperheroType]> {
        setPaginationOffset(0)
        return marvelRepository.get(named: nil, offset: offset, limit: Constants.limit)
    }
}

// MARK: - Private

extension GetSuperheroUseCase {
    
    private enum Constants {
        static let limit: Int = 50
    }
    
    mutating func setPaginationOffset(_ offset: Int) {
        self.offset = offset
    }
}
