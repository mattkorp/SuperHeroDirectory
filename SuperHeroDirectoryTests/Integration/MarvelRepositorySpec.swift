//
//  MarvelRepositorySpec.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import XCTest
@testable import SuperHeroDirectory

class MarvelRepositorySpec: XCTestCase {

    var sut: MarvelRepositoryProtocol!

    override func setUp() {
        sut = MarvelRepositoryMock()
    }

    func testGetFlights() {
        let numRequestedHeroes = 5
        sut.get(named: nil, pageInfo: (offset: 5, limit: numRequestedHeroes))
            .onSuccess { XCTAssertNotNil($0) }
            .onSuccess { XCTAssert($0.count == numRequestedHeroes)}
            .onFailure { XCTFail(($0 as! HTTPError).localizedDescription) }
    }
}
