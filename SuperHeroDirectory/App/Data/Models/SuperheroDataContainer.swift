//
//  SuperheroDataContainer.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

public struct SuperheroDataContainer {
    
    // The requested offset (number of skipped results) of the call.
    public let offset: Int?
    // The requested result limit.
    public let limit: Int?
    // The total number of resources available given the current filter set.
    public let total: Int?
    // The total number of results returned by this call.
    public let count: Int?
    // The list of characters returned by the call.
    public let results: [Superhero]
}

// MARK: - Decodable

extension SuperheroDataContainer: Decodable {
    
    private enum CodingKeys: CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
