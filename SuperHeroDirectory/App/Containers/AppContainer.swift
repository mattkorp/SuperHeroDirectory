//
//  AppContainer.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

// MARK: - AppContainer

// Adopts all sub-module containers
protocol AppContainer: SearchListContainer, DetailsContainer { }
