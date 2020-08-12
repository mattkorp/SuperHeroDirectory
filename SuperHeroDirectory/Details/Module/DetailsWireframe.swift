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

    let superhero: SuperheroType

    func build(router: DetailsRouterProtocol) -> DetailsViewController {
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter(superhero: superhero)

        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController

        return viewController
    }
}
