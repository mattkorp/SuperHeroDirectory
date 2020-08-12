//
//  LabelStyles.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// Label Styles

func multiLineStyle(_ label: UILabel) {
    label.numberOfLines = 0
}

// Color

func darkGreyStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.darkGrey)
}

// Font

func paragraph24TextStyle(_ label: UILabel) {
    label.font = UIFont.boldSystemFont(ofSize: 24)
}

func navigationItemTextStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.darkGrey)
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.backgroundColor = .clear
    label.textAlignment = .center
}

// Composed styles

let largeDarkMultilineStyle = darkGreyStyle
    + multiLineStyle
    + paragraph24TextStyle
