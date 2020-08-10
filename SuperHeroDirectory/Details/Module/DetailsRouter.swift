//
//  DetailsRouter.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 10/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: DetailsRouterProtocol - declaration

protocol DetailsRouterProtocol: class {
//    
//    func showDetails(with flightGroup: FlightGroup)
}

// MARK: DetailsRouter Module Router

final class DetailsRouter {

    var viewController: DetailsViewController {
        let viewController = _viewController ?? builder.build(router: self)
        _viewController = viewController
        return viewController
    }

    private let builder: DetailsWireframe
    private weak var _viewController: DetailsViewController?

    init(superhero: Superhero) {
        builder = DetailsWireframe(superhero: superhero)
    }
}

// MARK: - DetailsRouterProtocol - implementation

extension DetailsRouter: DetailsRouterProtocol {
//
//    func showDetails(with flightGroup: FlightGroup) { /* details info here */ }
}
