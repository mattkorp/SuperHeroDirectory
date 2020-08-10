//
//  Superhero.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

public struct Superhero: Decodable {
    // The name of the character.
    public let name: String?
    // A short bio or description of the character.
    public let description: String?
    // The representative image for this character.
    public let thumbnail: Image
    
    private enum CodingKeys: CodingKey {
        case name
        case description
        case thumbnail
    }
}
