//
//  ViewStyles.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// View Styles

func clearTableViewStyle(_ tableView: UITableView) {
    tableView.separatorColor = .clear
    tableView.backgroundColor = .white
}

func superLightGreyBackgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.superLightGrey.color
}

func lightGreyBackgroundStyle(_ view: UIView) {
    view.backgroundColor = ColorName.lightGrey.color
}

// Composed styles

let tableViewStyle = clearTableViewStyle + superLightGreyBackgroundStyle
