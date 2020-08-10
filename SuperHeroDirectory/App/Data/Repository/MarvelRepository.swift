//
//  MarvelRepository.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - MarvelRepositoryProtocol declaration

protocol MarvelRepositoryProtocol {
    /// fetch heroes from endpoint
    func get(named: String?, offset: Int, limit: Int, completion: @escaping ResultVoidClosure<RawSuperheroData>)
}

// MARK: - MarvelRepository

final class MarvelRepository {

    private struct MarvelTask: Task {
        
        var baseURL: URL = URL(string: "https://gateway.marvel.com:443/v1/public/characters")!
        
        var parameters: Parameters? {
            if let named = named {
                return [
                        "limit": limit,
                        "offset": offset,
                        "nameStartsWith": named,
                        "ts": APIKeys.dateHash.0,
                        "apikey": APIKeys.marvelPublic,
                        "hash": APIKeys.dateHash.1]
            }
            return [
                    "limit": limit,
                    "offset": offset,
                    "ts": APIKeys.dateHash.0,
                    "apikey": APIKeys.marvelPublic,
                    "hash": APIKeys.dateHash.1]
        }
        
        // MARK: - Private
        
        let named: String?
        let offset: Int
        let limit: Int
        
        init(named: String?, offset: Int, limit: Int) {
            self.named = named
            self.offset = offset
            self.limit = limit
        }
    }
}

// MARK: - MarvelRepositoryProtocol - implementation

extension MarvelRepository: MarvelRepositoryProtocol {

    func get(named: String?, offset: Int, limit: Int, completion: @escaping ResultVoidClosure<RawSuperheroData>) {
        let task = MarvelTask(named: named, offset: offset, limit: limit)
        task.request.responseObject(completion)
    }
}
