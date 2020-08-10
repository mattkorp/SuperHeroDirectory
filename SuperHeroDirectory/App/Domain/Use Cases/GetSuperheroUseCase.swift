//
//  GetSuperheroUseCase.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol GetSuperheroUseCaseProtocol {
    func fetchHeroes(named: String?, offset: Int, limit: Int, completion: @escaping ResultVoidClosure<([Superhero], Int)>)
}

struct GetSuperheroUseCase {
    
    let marvelRepository: MarvelRepositoryProtocol
    
    init(marvelRepository: MarvelRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
}

extension GetSuperheroUseCase: GetSuperheroUseCaseProtocol {
    
    func fetchHeroes(named: String?, offset: Int, limit: Int, completion: @escaping ResultVoidClosure<([Superhero], Int)>) {
        
        marvelRepository.get(named: named, offset: offset, limit: limit) { results in
            switch results {
                case .success(let superheroes):
                    completion(.success((superheroes.data?.results ?? [], offset + limit)))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
