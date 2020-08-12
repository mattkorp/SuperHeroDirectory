//
//  SearchListRouter.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: SearchListRouterProtocol - declaration

protocol SearchListRouterProtocol: class {
    
    func showDetails(with hero: SuperheroProtocol)
}

// MARK: SearchListRouter Module Router

final class SearchListRouter {

    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(router: self)
        _viewController = viewController
        return viewController
    }

    private let builder: SearchListWireframe
    private weak var _viewController: SearchListViewController?

    init(container: SearchListContainer) {
        builder = SearchListWireframe(container: container)
    }
}

// MARK: - OverviewRouterProtocol - implementation

extension SearchListRouter: SearchListRouterProtocol {

    func showDetails(with hero: SuperheroProtocol) {
        let detailsRouter = DetailsRouter(superhero: hero)
        viewController.navigationController?.pushViewController(detailsRouter.viewController, animated: true)
    }
}
