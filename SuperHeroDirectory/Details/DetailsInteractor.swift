//
//  DetailsInteractor.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 10/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - DetailsInteractorProtocol - declaration

protocol DetailsInteractorProtocol {
    // Fetch Object from Data Layer
    func fetch()
}

// MARK: - DetailsInteractor Module Interactor

final class DetailsInteractor {

    weak var presenter: DetailsPresenter?

    private let superhero: Superhero

    init(superhero: Superhero) {
        self.superhero = superhero
    }
}

// MARK: - DetailsInteractorProtocol - implementation

extension DetailsInteractor: DetailsInteractorProtocol {

    func fetch() {
        self.presenter?.interactor(didFetch: superhero)
    }
}

