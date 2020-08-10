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
    // Fetch Object from Data Layer
    func fetch()
    func fetch(name: String)
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

    func fetch() {
        getSuperheroUseCase.fetchHeroes(named: nil, offset: offset, limit: 30) { [weak self] result in
            guard let self = `self` else { return }
            switch result {
            case .success((let heroes, let newOffset)):
                self.offset = newOffset
                self.presenter?.interactor(didFetch: heroes, isRefreshing: false)
            case .failure(let error):
                self.presenter?.interactor(didFailWith: error)
            }
        }
    }
    
    func fetch(name: String) {
        offset = 0
        getSuperheroUseCase.fetchHeroes(named: name, offset: offset, limit: 30) { [weak self] result in
            guard let self = `self` else { return }
            switch result {
            case .success((let heroes, let newOffset)):
                self.offset = newOffset
                self.presenter?.interactor(didFetch: heroes, isRefreshing: true)
            case .failure(let error):
                self.presenter?.interactor(didFailWith: error)
            }
        }
    }
    
    func refresh() {
        offset = 0
        fetch()
    }
}

