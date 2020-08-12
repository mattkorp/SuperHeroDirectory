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
    /// The presenter creates viewmodel from injected entity and serves to view
    func fetch()
}

// MARK: - DetailsPresenter Module Presenter

final class DetailsPresenter {

    weak var router: DetailsRouterProtocol?
    weak var view: DetailsViewControllerProtocol?

    private let superhero: SuperheroType

    init(superhero: SuperheroType) {
        self.superhero = superhero
    }
}

// MARK: - DetailsPresenterProtocol - implementation

extension DetailsPresenter: DetailsPresenterProtocol {

    func fetch() {
        view?.startLoading()
        let presentable = DetailsViewModel(superhero: superhero)
        view?.consume(presentable: presentable)
        view?.stopLoading()
    }
}
