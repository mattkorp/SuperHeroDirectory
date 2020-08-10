//
//  Request.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// Task - declaration
// - conform to this protocol to create an HTTP task
public protocol Task {
    
    // required
    var baseURL: URL { get }

    // optional
    var path: String? { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod  { get }
    var request: Request { get }
}

public extension Task {

    var path: String? { nil }
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders? { [:] }
    var method: HTTPMethod { .get }

    var request: Request {
        let url = path.flatMap(baseURL.appendingPathComponent) ?? baseURL
        
        return Request(url: url, method: method, parameters: parameters, headers: headers)
    }
}
