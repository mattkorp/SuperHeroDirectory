//
//  TextStyles.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// TextStyle

struct TextStyle {

    let font: UIFont
    let lineHeight: CGFloat
    let uppercase: Bool
    let lineBreakMode: NSLineBreakMode

    init(font: UIFont,
         fallbackFont: UIFont? = nil,
         lineHeight: CGFloat,
         uppercase: Bool = false,
         lineBreakMode: NSLineBreakMode = .byTruncatingTail) {
        self.font = font
        self.lineHeight = lineHeight
        self.uppercase = uppercase
        self.lineBreakMode = lineBreakMode
    }
}

extension TextStyle {

    static let alpha = TextStyle(
        font: UIFont.boldSystemFont(ofSize: 16),
        lineHeight: 20)

    static let beta = TextStyle(
        font: UIFont.boldSystemFont(ofSize: 24),
        lineHeight: 30)
}
