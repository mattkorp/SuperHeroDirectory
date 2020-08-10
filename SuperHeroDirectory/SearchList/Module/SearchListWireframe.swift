//
//  SearchListWireframe.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - SearchListWireframe

struct SearchListWireframe {

    let container: SearchListContainer

    func build(router: SearchListRouter) -> SearchListViewController {

        let viewController = SearchListViewController()
        let interactor = SearchListInteractor(getSuperheroUseCase: container.getSuperheroUseCase)
        let presenter = SearchListPresenter()

        interactor.presenter = presenter
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController

        return viewController
    }
}
