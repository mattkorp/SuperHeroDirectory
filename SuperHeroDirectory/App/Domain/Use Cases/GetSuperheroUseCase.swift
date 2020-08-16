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
    func fetch(with pageInfo: PageInfo) -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository with search parameter
    func fetch(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository with pagination
    func fetchMore(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]>
    /// Fetch characters from marvel repository
    func refresh(with pageInfo: PageInfo) -> Promise<[SuperheroType]>
}

struct GetSuperheroUseCase {

    private let marvelRepository: MarvelRepositoryProtocol

    init(marvelRepository: MarvelRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
}

extension GetSuperheroUseCase: GetSuperheroUseCaseProtocol {
    
    func fetch(with pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        marvelRepository.get(named: nil, pageInfo: pageInfo)
    }
    
    func fetch(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        marvelRepository.get(named: startsWith, pageInfo: pageInfo)
    }
    
    func fetchMore(startsWith: String, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        marvelRepository.get(named: startsWith, pageInfo: pageInfo)
    }
    
    func refresh(with pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        marvelRepository.get(named: nil, pageInfo: pageInfo)
    }
}
