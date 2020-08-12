//
//  SearchListViewPresenterSpec.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import SuperHeroDirectory

class SearchListViewPresenterSpec: QuickSpec {
    
    override func spec() {

        var sut: SearchListPresenter!
        var searchListView: SearchListView!
        var viewModels: [SearchListViewPresentable]!
        
        beforeEach {
            let container = ContainerMock()
            let router = SearchListRouter(container: container)
            let viewController = router.viewController as? SearchListViewController
            searchListView = viewController?.view as? SearchListView
            viewModels = searchListView?.dataSource?.object()
            sut = viewController?.presenter as? SearchListPresenter
        }
        
        describe("fetch") {
            it("sends vm to view") {
                sut.fetch()
                expect(viewModels.count).to(equal(1))
                expect(viewModels.first?.name).to(equal("Fixture name"))
                searchListView.delegate?.view(didSelect: viewModels.first!)
            }
        }
    }
}


