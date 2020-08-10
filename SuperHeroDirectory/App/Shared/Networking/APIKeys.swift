//
//  APIKeys.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/9/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

public struct APIKeys {

    public static let marvelPublic = "80e13c0fe2bed509e0f6e4c6aa979139"
    public static let marvelPrivate = "caa74b1b6b26cc4bd5a35ff8cef5e1386bbfe313"
    
    public static var dateHash: (dateString: String, hashString: String) {
        let date = String(format: "%d", Int(Date().timeIntervalSince1970))
        let hash = (date + marvelPrivate + marvelPublic).md5()
        
        return (dateString: date, hashString: hash)
    }
}
