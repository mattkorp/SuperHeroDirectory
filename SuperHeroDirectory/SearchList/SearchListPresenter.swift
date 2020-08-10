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
    /// The presenter fetches data from Interactor
    func fetch()
    func fetch(name: String)
    /// The presenter reload data from the interactor
    func refresh()
    /// The Interactor informs Presenter fetch was successful
    func interactor(didFetch data: ([Superhero]), isRefreshing: Bool)
    /// The Interactor informs Presenter fetch failed
    func interactor(didFailWith error: Error)
    /// View did Select group
    func view(didSelect presentable: SearchListViewPresentable)
}

// MARK: - SearchListPresenter Module Presenter

final class SearchListPresenter {

    weak var router: SearchListRouterProtocol?
    weak var view: SearchListViewControllerProtocol?
    var interactor: SearchListInteractorProtocol?
}

// MARK: - SearchListPresenterProtocol - implementation

extension SearchListPresenter: SearchListPresenterProtocol {
    
    func fetch() {
        view?.startLoading()
        interactor?.fetch()
    }
    
    func fetch(name: String) {
        guard name.count > 2 else {
            return
        }
        interactor?.fetch(name: name)
    }

    func refresh() {
        interactor?.refresh()
    }

    func interactor(didFetch data: ([Superhero]), isRefreshing: Bool) {
        let presentables = data.map { superhero in
            SearchListViewModel(superhero: superhero)
        }
        view?.consume(presentables: presentables, isRefreshing: isRefreshing)
        view?.stopLoading()
    }

    func interactor(didFailWith error: Error) {
        view?.stopLoading()
        let errorMessage = (error as? HTTPError).flatMap { $0.localizedDescription } ?? "error"
//            ?? L10n.General.Error.text
//        view?.show(title: L10n.General.Error.title, message: errorMessage)
        view?.show(title: "Error", message: errorMessage)
    }

    func view(didSelect presentable: SearchListViewPresentable) {
        router?.showDetails(with: presentable.superhero)
    }
}
