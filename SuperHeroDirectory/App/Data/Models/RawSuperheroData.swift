//
//  RawSuperheroData.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

struct RawSuperheroData {
    
    var data: SuperheroDataContainer?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(SuperheroDataContainer?.self, forKey: .data)
    }
}

// MARK: - Decodable

extension RawSuperheroData: Decodable {
    
    private enum CodingKeys: CodingKey {
        case data
    }
}
