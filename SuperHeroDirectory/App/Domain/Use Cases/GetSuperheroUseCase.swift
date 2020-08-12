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
    mutating func fetch() -> Promise<[SuperheroProtocol]>
    /// Fetch characters from marvel repository with search parameter
    mutating func fetch(startsWith: String) -> Promise<[SuperheroProtocol]>
    /// Fetch characters from marvel repository with pagination
    mutating func fetchMore(startsWith: String) -> Promise<[SuperheroProtocol]>
    /// Fetch characters from marvel repository
    mutating func refresh() -> Promise<[SuperheroProtocol]>
}

struct GetSuperheroUseCase {
    
    private let marvelRepository: MarvelRepositoryProtocol
    private var offset: Int = 0
    private let limit: Int = 50

    init(marvelRepository: MarvelRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
}

extension GetSuperheroUseCase: GetSuperheroUseCaseProtocol {
    
    mutating func fetch() -> Promise<[SuperheroProtocol]> {
        setPaginationOffset(offset + limit)
        return marvelRepository.get(named: nil, offset: offset, limit: limit)
    }
    
    mutating func fetch(startsWith: String) -> Promise<[SuperheroProtocol]> {
        setPaginationOffset(0)
        return marvelRepository.get(named: startsWith, offset: offset, limit: limit)
    }
    
    mutating func fetchMore(startsWith: String) -> Promise<[SuperheroProtocol]> {
        setPaginationOffset(offset + limit)
        return marvelRepository.get(named: startsWith, offset: offset, limit: limit)
    }
    
    mutating func refresh() -> Promise<[SuperheroProtocol]> {
        setPaginationOffset(0)
        return marvelRepository.get(named: nil, offset: offset, limit: limit)
    }
}

// MARK: - Private methods

extension GetSuperheroUseCase {
    
    mutating func setPaginationOffset(_ offset: Int) {
        self.offset = offset
    }
}
