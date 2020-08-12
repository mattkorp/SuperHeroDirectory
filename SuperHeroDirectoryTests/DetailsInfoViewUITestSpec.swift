//
//  DetailsInfoViewUITestSpec.swift
//  SuperHeroDirectoryUITests
//
//  Created by Matthew Korporaal on 8/7/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

@testable import SuperHeroDirectory
import Nimble
import Quick
import SnapshotTesting

class DetailsInfoViewUITestSpec: QuickSpec {
    override func spec() {
        describe("Snapshots") {
            context("default") {
                it("looks right") {
                    let presentable = DetailsViewPresentableMock()
                    let sut = DetailsInfoView.loadFromNib()
                    sut.presentable = presentable
                    let height = sut.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                    sut.frame = CGRect(x: 0, y: 0, width: 375, height: height)
                    assertSnapshot(matching: sut, as: .image)
                    assertSnapshot(matching: sut, as: .recursiveDescription)
                }
            }
        }
    }
}
