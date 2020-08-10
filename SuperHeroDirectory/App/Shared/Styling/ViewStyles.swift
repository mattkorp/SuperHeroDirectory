//
//  ViewStyles.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// View Styles

func bottomShadowStyle(_ view: UIView) {
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.clear.cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 3)
    view.layer.shadowOpacity = 0.1
}

func clearTableViewStyle(_ tableView: UITableView) {
    tableView.separatorColor = .clear
    tableView.backgroundColor = .white
}

func noCellSelectionStyle(_ cell: UITableViewCell) {
    cell.selectionStyle = .none
}

// background

func whiteBackgroundStyle(_ view: UIView) {
    view.backgroundColor = UIColor(named: .white)
}

func clearBackgroundStyle(_ view: UIView) {
    view.backgroundColor = .clear
}

func superLightGreyBackgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.superLightGrey.color
}

func lightGreyBackgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.lightGrey.color
}

func greenBackgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.green.color
}

func darkgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.dark.color
}

// Composed styles

let greenSeparatorStyle = greenBackgroundStyle
let greySeparatorStyle = greenBackgroundStyle
let largeSeparatorStyle = superLightGreyBackgroundStyle + bottomShadowStyle
let tableViewStyle = clearTableViewStyle + superLightGreyBackgroundStyle
let tableViewCellStyle = noCellSelectionStyle + whiteBackgroundStyle
let tableViewCellViewStyle = whiteBackgroundStyle
