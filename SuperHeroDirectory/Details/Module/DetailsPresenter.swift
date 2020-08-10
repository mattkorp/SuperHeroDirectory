//
//  DetailsPresenter.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 10/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - DetailsPresenterProtocol - Declaration

protocol DetailsPresenterProtocol {
    /// The presenter fetches data from Interactor
    func fetch()
    /// The Interactor informs Presenter fetch was successful
    func interactor(didFetch superhero: Superhero)
}

// MARK: - DetailsPresenter Module Presenter

final class DetailsPresenter {

    weak var router: DetailsRouterProtocol?
    weak var view: DetailsViewControllerProtocol?
    var interactor: DetailsInteractorProtocol?
}

// MARK: - DetailsPresenterProtocol - implementation

extension DetailsPresenter: DetailsPresenterProtocol {

    func fetch() {
        view?.startLoading()
        interactor?.fetch()
    }

    func interactor(didFetch superhero: Superhero) {
        let presentable = DetailsViewModel(superhero: superhero)
        view?.consume(presentable: presentable)
        view?.stopLoading()
    }
}
