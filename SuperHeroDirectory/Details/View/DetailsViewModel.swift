//
//  DetailsViewModel.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/10/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol DetailsViewPresentable {
    var name: String { get }
    var nameLabel: String { get }
    var bio: String { get }
    var imagePath: String? { get }
    var noImageName: String { get }
}

// MARK: - DetailsViewModel Module Entity

struct DetailsViewModel: DetailsViewPresentable {

    var superhero: Superhero
    
    var name: String {
        return superhero.name?.uppercased() ?? ""
    }
    
    var nameLabel: String {
        return L10n.Detail.Bio.title
    }
    
    var bio: String {
        guard let description = superhero.description, !description.isEmpty else {
            return L10n.Detail.Bio.text
        }
        return description
    }
    
    var imagePath: String? {
        guard let path = superhero.thumbnail.path,
            let format = superhero.thumbnail.format,
            !path.contains(noImageName) else {
            return nil
        }

        return path + "." + format
    }
    
    var noImageName: String {
        return "image_not_available"
    }
}
