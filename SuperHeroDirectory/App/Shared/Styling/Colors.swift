//
//  Colors.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//
//  Inspired by: https://github.com/SwiftGen/SwiftGen
//

import UIKit.UIColor
internal typealias Color = UIColor

struct ColorName {
    let rgbaValue: UInt32
    var color: Color { Color(named: self) }

    static let black = ColorName(rgbaValue: 0x333333ff)
    static let white = ColorName(rgbaValue: 0xffffffff)
    static let silverDark = ColorName(rgbaValue: 0xc1c1c2ff)
    static let superLightGrey = ColorName(rgbaValue: 0xDADEDFff)
    static let lightGrey = ColorName(rgbaValue: 0xC6C6C8ff)
    static let darkGrey = ColorName(rgbaValue: 0x282A35ff)
    static let green = ColorName(rgbaValue: 0x517664ff)
    static let dragonGreen = ColorName(rgbaValue: 0x66c28bff)
    static let dark = ColorName(rgbaValue: 0x2d3319ff)
}

internal extension Color {
    
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    convenience init(named color: ColorName) {
        self.init(rgbaValue: color.rgbaValue)
    }
}
