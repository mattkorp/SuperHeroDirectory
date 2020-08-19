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
    /// Fetch data with name fragment
    func fetch(searchText: String)
    /// Fetch data with name fragment
    func fetchMore(searchText: String)
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
        tableView.setContentOffset(.zero, animated: true)
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            let topOffest = CGPoint(x: 0, y: -self.tableView.contentInset.top)
            self.tableView.setContentOffset(topOffest, animated: true)
        }
    }
}

// MARK: - Private helpers

private extension SearchListView {

    func setupUI() {
        addSubview(searchBar)
        searchBar.delegate = self
        searchBar.placeholder = L10n.SearchList.Searchbar.Placeholder.text
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
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    func endSearchBarEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
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
        configure(cell, title: presentables?[indexPath.row].name)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, title: String?) {
        cell |> searchListCellStyle
        cell.textLabel?.text = title
    }
}

// MARK: - UITableViewDelegate

extension SearchListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hero = presentables?[indexPath.row] else { return }
        delegate?.view(didSelect: hero)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            searchBar.text.flatMap {
                $0.isEmpty ? delegate?.fetch() : delegate?.fetchMore(searchText: $0)
            }
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
        delegate?.fetch(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing(searchBar)
        refetchData()
    }
}
