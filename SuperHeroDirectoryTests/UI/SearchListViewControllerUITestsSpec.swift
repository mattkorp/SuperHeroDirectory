//
//  SearchListViewControllerUITestsSpec.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Quick
import SnapshotTesting

class SearchListViewControllerUITestsSpec: QuickSpec {
    
    override func spec() {
        
        describe("Snapshots") {
            context("default") {
                it("looks right") {
                    let container = Container()
                    let searchListRouter = SearchListRouter(container: container)
                    let sut = searchListRouter.viewController
                    
                    assertSnapshot(matching: sut, as: .image)
                }
            }
        }
    }
}
