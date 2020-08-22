//
//  SearchListViewDataSource.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/22/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: SearchListViewDataSource

protocol SearchListViewDataSource where Self: SearchListViewData {
    /// Set Object for the UI Component
    var objects: [SearchListViewPresentable]? { set get }
}

protocol SearchListViewDataSourceDelegate: class {
    func dataSourceDidUpdate()
}

final class SearchListViewData: NSObject {

    weak var delegate: SearchListViewDataSourceDelegate?
    
    private var data: [SearchListViewPresentable]? = nil
}

// MARK: - UITableViewDataSource - implementation

extension SearchListViewData: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        configure(cell, title: data?[indexPath.row].name)

        return cell
    }
    
    func configure(_ cell: UITableViewCell, title: String?) {
        cell |> searchListCellStyle
        cell.textLabel?.text = title
    }
}

// MARK: - SearchListViewUIDataSource - implementation

extension SearchListViewData: SearchListViewDataSource {
    
    var objects: [SearchListViewPresentable]? {
        get { data }
        set { data = newValue.flatMap { (data ?? []) + $0 }
            if data?.isEmpty == false {
                delegate?.dataSourceDidUpdate()
            }
        }
    }
}
