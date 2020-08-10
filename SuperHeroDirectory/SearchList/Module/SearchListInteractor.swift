//
//  SearchListInteractor.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - SearchListInteractorProtocol - declaration

protocol SearchListInteractorProtocol {
    // Fetch heroes from Data Layer (paginated)
    func fetch()
    // Fetch heroes from Data Layer name starting with
    func fetch(startsWith: String)
    // Fetch more heroes from Data Layer name starting with (paginated)
    func fetchMore(startsWith: String)
    // Fetch heroes from Data Layer
    func refresh()
}

// MARK: - SearchListInteractor Module Interactor

final class SearchListInteractor {

    weak var presenter: SearchListPresenter?

    private let getSuperheroUseCase: GetSuperheroUseCaseProtocol
    private var offset: Int

    init(getSuperheroUseCase: GetSuperheroUseCaseProtocol) {
        self.getSuperheroUseCase = getSuperheroUseCase
        self.offset = 0
    }
}

// MARK: - SearchListInteractorProtocol - implementation

extension SearchListInteractor: SearchListInteractorProtocol {
    
     func refresh() {
         resetPaginationOffset()
         fetch(named: nil)
     }
    
    func fetch() {
        fetch(named: nil)
    }
    
    func fetch(startsWith: String) {
        resetPaginationOffset()
        fetch(named: startsWith)
    }
    
    func fetchMore(startsWith: String) {
        fetch(named: startsWith)
    }
}

// MARK: - Private methods

private extension SearchListInteractor {
    
    func fetch(named: String? = nil) {
        getSuperheroUseCase.fetchHeroes(named: named, offset: offset, limit: 50)
            .onSuccess { (heroes, newOffset) in
                self.offset = newOffset
                self.presenter?.interactor(didFetch: heroes)
            }
            .onFailure { self.presenter?.interactor(didFailWith: $0) }
    }
    
    func resetPaginationOffset() {
        offset = 0
    }
}

