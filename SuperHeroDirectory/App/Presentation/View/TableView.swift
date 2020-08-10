//
//  TableView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

open class TableView: UITableView { }

extension TableView {

    func configure(delegate: UITableViewDelegate? = nil,
                   dataSource: UITableViewDataSource? = nil,
                   estimatedHeight: CGFloat = 100) {
        self.delegate = delegate
        self.dataSource = dataSource
        self |> tableViewStyle
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = estimatedHeight
    }
}
