//
//  SearchListViewModel.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol SearchListViewPresentable {
    var superhero: SuperheroType { get set }
    var name: String { get }
    var bio: String? { get }
}

// MARK: - SearchListViewModel Module Entity

struct SearchListViewModel: SearchListViewPresentable {

    var superhero: SuperheroType
    
    var name: String { superhero.name ?? "" }
    
    var bio: String? { superhero.description }
}
