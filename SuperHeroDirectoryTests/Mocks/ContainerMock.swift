//
//  ContainerMock.swift
//  SuperHeroDirectoryTests
//
//  Created by Matthew Korporaal on 8/12/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation
@testable import SuperHeroDirectory

class ContainerMock: AppContainer {
    
    var getSuperheroUseCase: GetSuperheroUseCaseProtocol
    
    init() {
        getSuperheroUseCase = GetSuperheroUseCaseStub()
    }
}
