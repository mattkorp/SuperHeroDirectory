//
//  Container.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - Container

// Implementation of AppContainer protocol. Builds all dependencies for the app.
final class Container: AppContainer {

    // MARK: - Repository

    let marvelRepository: MarvelRepositoryProtocol

    // MARK: - Use Cases

    let getSuperheroUseCase: GetSuperheroUseCaseProtocol

    init() {

        // MARK: - Repository

        marvelRepository = MarvelRepository()
        
        // MARK: - Use Cases

        getSuperheroUseCase = GetSuperheroUseCase(marvelRepository: marvelRepository)
    }
}
