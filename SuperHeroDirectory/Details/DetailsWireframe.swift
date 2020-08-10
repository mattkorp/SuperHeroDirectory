//
//  DetailsWireframe.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 10/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - DetailsWireframe

struct DetailsWireframe {

    let superhero: Superhero

    func build(router: DetailsRouterProtocol) -> DetailsViewController {
        let viewController = DetailsViewController()
        let interactor = DetailsInteractor(superhero: superhero)
        let presenter = DetailsPresenter()

        interactor.presenter = presenter
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController

        return viewController
    }
}
