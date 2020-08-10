//
//  SearchListView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: SearchListViewUIDelegate

protocol SearchListViewUIDelegate {
    /// Returns selected superhero viewmodel to view
    func view(didSelect presentable: SearchListViewPresentable)
    /// Fetch data from endpoint
    func fetch()
    func fetch(name: String)
    /// Re-Fetch data from endpoint
    func refresh()
}

// MARK: SearchListViewUIDataSource

protocol SearchListViewDataSource {
    /// Set Object for the UI Component
    func object() -> [SearchListViewPresentable]?
}

// MARK: - SearchListView

final class SearchListView: UIView {

    // MARK: - Public
    var delegate: SearchListViewUIDelegate?
    var dataSource: SearchListViewDataSource?

    // MARK: - Private
    private var presentables: [SearchListViewPresentable]?
    // TODO: move tableView and searchView to own classes
    private let tableView = TableView()
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()

    // MARK: - viewcontroller lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }

    // MARK: loading methods

    func reloadData() {
        presentables = dataSource?.object()
        
        if presentables?.isEmpty == true {
            // TODO: show empty message
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    @objc
    func refetchData() {
        delegate?.refresh()
    }
}

// MARK: - Private helpers

private extension SearchListView {

    func setupUI() {
        addSubview(searchBar)
        searchBar.delegate = self
        searchBar.placeholder = "SEARCH"
        searchBar.showsCancelButton = true
        hideKeyboardWhenTappedAround()
        
        addSubview(tableView)
        tableView.configure(delegate: self, dataSource: self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.refreshControl?.addTarget(self, action: #selector(refetchData), for: .valueChanged)
    }

    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.pinToSafeAreaTop()
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tableView.pinToSafeAreaBottom()
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension SearchListView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presentables?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = presentables?[indexPath.row].name
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hero = presentables?[indexPath.row] else { return }
        delegate?.view(didSelect: hero)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 5.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 5.0 {
            delegate?.fetch()
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchListView: UISearchBarDelegate {

    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        endSearchBarEditing(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.fetch(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing(searchBar)
        refetchData()
    }
}

// MARK: - Private helpers

extension SearchListView {
        
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    private func endSearchBarEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
