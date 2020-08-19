//
//  SearchListState.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/19/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

struct SearchListState {
    
    var paginationUseCase: PaginationUseCaseProtocol
    var pageInfo: PageInfo { paginationUseCase.pageInfo }
    var viewState = ViewState.loading
    var pageState: PaginationState = .reset {
        didSet {
            pageState == .set ? paginationUseCase.setOffset() : paginationUseCase.resetOffset()
            viewState = .loading
        }
    }
                    
    enum PaginationState {
        case set
        case reset
    }
    
    enum ViewState {
        case loading
        case result(_ result: Promise<[SuperheroType]>)
    }
}

extension SearchListState.ViewState: Equatable {

    static func == (lhs: SearchListState.ViewState, rhs: SearchListState.ViewState) -> Bool {
        guard case (.loading, .loading) = (lhs, rhs) else { return false }
        return true
    }
}
