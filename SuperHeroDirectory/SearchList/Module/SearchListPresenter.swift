//
//  SearchListPresenter.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - SearchListPresenterProtocol - Declaration

protocol SearchListPresenterProtocol {
    /// The presenter fetches data from use case
    func fetch()
    /// The presenter fetches names from use case with search parameter
    func fetch(startsWith: String)
    /// Presenter fetches more of the current string
    func fetchMore(startsWith: String)
    /// The presenter reload data from the use case
    func refresh()
    /// View did Select group
    func view(didSelect presentable: SearchListViewPresentable)
}

// MARK: - SearchListPresenter Module Presenter

final class SearchListPresenter {

    weak var router: SearchListRouterProtocol?
    weak var view: SearchListViewControllerProtocol?
    
    private var getSuperheroUseCase: GetSuperheroUseCaseProtocol

    init(getSuperheroUseCase: GetSuperheroUseCaseProtocol) {
        self.getSuperheroUseCase = getSuperheroUseCase
    }
}

// MARK: - SearchListPresenterProtocol - implementation

extension SearchListPresenter: SearchListPresenterProtocol {
    
    func fetch() {
        view?.startLoading()
        getSuperheroUseCase.fetch()
            .onSuccess(handleSuccess).onFailure(handleError)
    }
    
    func fetch(startsWith: String) {
        let minSearchLength = 3
        guard startsWith.count >= minSearchLength else { return }
        getSuperheroUseCase.fetch(startsWith: startsWith)
            .onSuccess(handleSuccess).onFailure(handleError)
    }
    
    func fetchMore(startsWith: String) {
        getSuperheroUseCase.fetchMore(startsWith: startsWith)
            .onSuccess(handleSuccess).onFailure(handleError)
    }

    func refresh() {
        getSuperheroUseCase.refresh()
            .onSuccess(handleSuccess).onFailure(handleError)
    }
    
    func view(didSelect presentable: SearchListViewPresentable) {
        router?.showDetails(with: presentable.superhero)
    }
}

// MARK: - Private methods

private extension SearchListPresenter {

    func handleSuccess(_ heroes: ([SuperheroType])) {
        view?.stopLoading()

        guard heroes.count > 0 else { return }
        
        let presentables = heroes.map { SearchListViewModel(superhero: $0) }
        view?.consume(presentables: presentables)
    }

    func handleError(_ error: Error) {
        view?.stopLoading()
        let errorMessage = (error as? HTTPError)
            .flatMap { $0.localizedDescription } ?? L10n.General.Error.text
        view?.show(title: L10n.General.Error.title, message: errorMessage)
    }
}
