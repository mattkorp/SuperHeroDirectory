//
//  DetailsInfoViewPresentableMock.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Foundation

struct DetailsViewPresentableMock: DetailsViewPresentable {
    var name: String { "Fixture name text" }
    var nameLabel: String { "Fixture name label" }
    var bio: String { "Fixture bio text" }
    var imagePath: String? { "https://via.placeholder.com/150" }
    var noImageName: String { "image_not_available" }
}
