//
//  GetSuperheroUseCase.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol GetSuperheroUseCaseProtocol {
    func fetchHeroes(named: String?, offset: Int, limit: Int) -> Promise<([Superhero], Int)>
}

struct GetSuperheroUseCase {
    
    let marvelRepository: MarvelRepositoryProtocol
    
    init(marvelRepository: MarvelRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
}

extension GetSuperheroUseCase: GetSuperheroUseCaseProtocol {
    
    func fetchHeroes(named: String?, offset: Int, limit: Int) -> Promise<([Superhero], Int)> {
        return Promise<([Superhero], Int)> { fulfill, reject in
            self.marvelRepository.get(named: named, offset: offset, limit: limit)
                .thenMap { superheroes -> ([Superhero], Int) in
                    (superheroes.data?.results ?? [], offset + limit)
                }
                .onSuccess(fulfill)
                .onFailure(reject)
        }
    }
}
