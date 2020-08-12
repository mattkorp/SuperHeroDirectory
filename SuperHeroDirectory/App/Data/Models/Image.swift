//
//  Image.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

public struct Image {
    //  The directory path of to the image.
    public let path: String?
    // The file extension for the image.
    public let format: String?
}

// MARK: - Decodable

extension Image: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
}
