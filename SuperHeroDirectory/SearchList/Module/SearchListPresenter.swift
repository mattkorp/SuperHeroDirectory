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
    
    weak var router: SearchListRouterProtocol!
    weak var view: SearchListViewControllerProtocol!
    
    private let getSuperheroUseCase: GetSuperheroUseCaseProtocol
    
    private var state: SearchListState {
        didSet { updateView(with: state.viewState) }
    }
    
    init(getSuperheroUseCase: GetSuperheroUseCaseProtocol,
         paginationUseCase: PaginationUseCaseProtocol) {
        self.getSuperheroUseCase = getSuperheroUseCase
        self.state = SearchListState(paginationUseCase: paginationUseCase)
    }
}

// MARK: - SearchListPresenterProtocol - implementation

extension SearchListPresenter: SearchListPresenterProtocol {
    
    func fetch() {
        guard state.viewState != .loading else { return }
        state.pageState = .set
        state.viewState = .result(getSuperheroUseCase.fetch(with: state.pageInfo))
    }
    
    func fetch(startsWith: String) {
        guard startsWith.count >= Constants.minSearchLength else { return }
        state.pageState = .reset
        state.viewState = .result(getSuperheroUseCase.fetch(startsWith: startsWith, pageInfo: state.pageInfo))
    }
    
    func fetchMore(startsWith: String) {
        guard startsWith.count >= Constants.minSearchLength else { return }
        guard state.viewState != .loading else { return }
        state.pageState = .set
        state.viewState = .result(getSuperheroUseCase.fetchMore(startsWith: startsWith, pageInfo: state.pageInfo))
    }

    func refresh() {
        state.pageState = .reset
        state.viewState = .result(getSuperheroUseCase.refresh(with: state.pageInfo))
    }
    
    func view(didSelect presentable: SearchListViewPresentable) {
        router.showDetails(with: presentable.superhero)
    }
}

// MARK: - Private methods

private extension SearchListPresenter {

    func updateView(with viewState: SearchListState.ViewState) {
        switch viewState {
        case .loading:
            view.startLoading()
        case .result(let result):
            result
                .onSuccess(handleSuccess)
                .onFailure(handleError)
                .always(view.stopLoading)
        }
    }
    
    func handleSuccess(_ heroes: [SuperheroType]) {
        view.consume(presentables: viewModels(with: heroes))
    }

    func handleError(_ error: Error) {
        view.show(title: L10n.General.Error.title, message: errorMessage(from: error))
    }
    
    func viewModels(with heroes: [SuperheroType]) -> [SearchListViewPresentable] {
        heroes.map(SearchListViewModel.init)
    }
    
    func errorMessage(from error: Error) -> String {
        (error as? HTTPError).flatMap { $0.localizedDescription } ?? L10n.General.Error.text
    }
    
    enum Constants {
        static let minSearchLength = 3
    }
}
