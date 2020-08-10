//
//  SearchListViewModel.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol SearchListViewPresentable {
    var superhero: Superhero { get set }
    var name: String { get }
    var bio: String? { get }
    var imagePath: String? { get }
}

// MARK: - SearchListViewModel Module Entity

struct SearchListViewModel: SearchListViewPresentable {

    var superhero: Superhero
    
    var name: String {
        return superhero.name ?? ""
    }
    
    var bio: String? {
        return superhero.description
    }
    
    var imagePath: String? {
        guard let path = superhero.thumbnail.path,
            let format = superhero.thumbnail.format,
            !path.contains("image_not_available") else {
            return nil
        }

        return path + "." + format
    }
}
