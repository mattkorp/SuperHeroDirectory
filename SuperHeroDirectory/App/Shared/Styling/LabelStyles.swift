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

func whiteStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.white)
}

func blackStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.black)
}

func dragonGreenStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.dragonGreen)
}

func silverDarkStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.silverDark)
}

func darkGreyStyle(_ label: UILabel) {
    label.textColor = UIColor(named: ColorName.darkGrey)
}

// Font

func paragraph10TextStyle(_ label: UILabel) {
    label.font = UIFont.boldSystemFont(ofSize: 12)
}

func paragraph12TextStyle(_ label: UILabel) {
    label.font = UIFont.boldSystemFont(ofSize: 12)
}

func paragraph16TextStyle(_ label: UILabel) {
    label.font = UIFont.boldSystemFont(ofSize: 16)
}

func paragraph24TextStyle(_ label: UILabel) {
    label.font = UIFont.boldSystemFont(ofSize: 24)
}

// Composed styles

let smallSilverDarkStyle = silverDarkStyle
    + paragraph12TextStyle

let mediumDarkMultilineStyle = multiLineStyle
    + darkGreyStyle
    + paragraph16TextStyle

let smallBlackStyle = blackStyle
    + paragraph12TextStyle

let mediumBlackStyle = blackStyle
    + paragraph16TextStyle

let mediumBlackMultilineStyle = multiLineStyle
    + blackStyle
    + paragraph16TextStyle

let largeGreenStyle = dragonGreenStyle
    + paragraph24TextStyle

let greenStyle = largeGreenStyle
