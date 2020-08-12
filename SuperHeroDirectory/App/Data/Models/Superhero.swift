//
//  Superhero.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol SuperheroType {
    var name: String? { get }
    var description: String? { get }
    var thumbnail: Image { get }
}

public struct Superhero: SuperheroType {
    
    // The name of the character.
    public let name: String?
    // A short bio or description of the character.
    public let description: String?
    // The representative image for this character.
    public let thumbnail: Image
}

// MARK: - Decodable

extension Superhero: Decodable {
    
    private enum CodingKeys: CodingKey {
        case name
        case description
        case thumbnail
    }
}
