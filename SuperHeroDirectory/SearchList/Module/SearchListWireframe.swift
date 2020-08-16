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
        let presenter = SearchListPresenter(
            getSuperheroUseCase: container.getSuperheroUseCase,
            paginationUseCase: container.paginationUseCase)

        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController

        return viewController
    }
}
