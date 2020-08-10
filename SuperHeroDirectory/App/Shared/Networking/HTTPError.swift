//
//  HTTPError.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// HTTPError
// - all http errors map to this, adopts Error protocol
public enum HTTPError: Error {
    case unreachable
    case clientError(underlying: Error)
    case serverError(response: URLResponse?)
    case decodingError(underlying: Error)
    case noData
}
