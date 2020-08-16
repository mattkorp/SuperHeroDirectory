//
//  SearchListContainer.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - SearchListContainer

protocol SearchListContainer {
    /// UseCase for all side effects needed for the grouped list SearchList module
    var getSuperheroUseCase: GetSuperheroUseCaseProtocol { get }
    var paginationUseCase: PaginationUseCaseProtocol { get }
}
