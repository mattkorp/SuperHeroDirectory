//
//  PaginationUseCase.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/16/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

protocol PaginationUseCaseProtocol {
    var pageInfo: PageInfo { get }
    
    mutating func resetOffset()
    mutating func setOffset()
}

typealias PageInfo = (offset: Int, limit: Int)

struct PaginationUseCase {

    private var offset: Int

    init() {
        self.offset = 0
    }
}

extension PaginationUseCase: PaginationUseCaseProtocol {
    
    var pageInfo: PageInfo { (offset, Constants.limit) }
    
    mutating func resetOffset() { offset = 0 }
    mutating func setOffset() { offset = Constants.limit + offset }
}

extension PaginationUseCase {
    
    private enum Constants {
        static let limit: Int = 50
    }
    
    private mutating func set(offset: Int) {
        self.offset = offset
    }
}
