//
//  DetailsViewControllerUITestsSpec.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Quick
import SnapshotTesting

class DetailsViewControllerUITestsSpec: QuickSpec {
    override func spec() {
        describe("Snapshots") {
            context("default") {
                it("looks right") {
                    let superhero = SuperheroMock()
                    let router = DetailsRouter(superhero: superhero)
                    let sut = router.viewController
                    assertSnapshot(matching: sut, as: .image)
                }
            }
        }
    }
}
