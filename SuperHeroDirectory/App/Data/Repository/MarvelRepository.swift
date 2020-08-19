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
    func get(named: String?, pageInfo: PageInfo) -> Promise<[SuperheroType]>
}

// MARK: - MarvelRepository

final class MarvelRepository {

    private struct MarvelTask: Task {
        
        var baseURL: URL? = URL(string: URLPath.characters)
        
        var parameters: Parameters? {
            var params: Parameters = [
                Keys.limit: pageInfo.limit,
                Keys.offset: pageInfo.offset,
                Keys.timestamp: APIKeys.dateHash.0,
                Keys.key: APIKeys.marvelPublic,
                Keys.hash: APIKeys.dateHash.1]
            name.flatMap { params[Keys.named] = $0 }
            
            return params
        }
        
        // MARK: - Private
        
        let name: String?
        let pageInfo: PageInfo
    }
}

// MARK: - MarvelRepositoryProtocol - implementation

extension MarvelRepository: MarvelRepositoryProtocol {

    func get(named: String?, pageInfo: PageInfo) -> Promise<[SuperheroType]> {
        let promise = Promise<[SuperheroType]>()
        (task(name: named, info: pageInfo)
            .request.responseObject() as Promise<RawSuperheroData>)
            .onSuccess { promise.fulfill($0.data?.results ?? []) }
            .onFailure(promise.reject)
        
        return promise
    }
}

// MARK: - Parameter keys & path

private extension MarvelRepository {
    
    enum Keys {
        static let limit = "limit"
        static let offset = "offset"
        static let timestamp = "ts"
        static let key = "apikey"
        static let hash = "hash"
        static let named = "nameStartsWith"
    }
    
    enum URLPath {
        static let characters = "https://gateway.marvel.com:443/v1/public/characters"
    }
    
    private func task(name: String?, info: PageInfo) -> MarvelTask {
        MarvelTask(name: name, pageInfo: info)
    }
}
