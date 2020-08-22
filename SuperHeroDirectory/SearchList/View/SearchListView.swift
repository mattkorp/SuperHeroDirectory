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

// MARK: - SearchListViewProtocol

protocol SearchListViewProtocol where Self: SearchListView {
    var delegate: SearchListViewUIDelegate? { get set }
    func consume(data: [SearchListViewPresentable]?)
}

// MARK: - SearchListView

final class SearchListView: UIView {

    // MARK: - Public
    var delegate: SearchListViewUIDelegate?
    var dataSource: SearchListViewDataSource?

    // MARK: - Private

    private let tableView = TableView()
    private let searchBar = SearchListViewSearchBar()
    private let refreshControl = UIRefreshControl()

    // MARK: - viewcontroller lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSource = SearchListViewData()
        dataSource?.delegate = self
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
        addSubview(tableView)
        searchBar.searchDelegate = self
        tableView.configure(delegate: self, dataSource: dataSource)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.refreshControl?.addTarget(self, action: #selector(refetchData), for: .valueChanged)
        addDismissKeyboardTapGesture()
    }

    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.pinToSafeAreaTop()
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tableView.pinToSafeAreaBottom()
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    }
    
    func addDismissKeyboardTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.endSearchBarEditing()
    }
}

// MARK: - UITableViewDelegate

extension SearchListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hero = dataSource?.objects?[indexPath.row] else { return }
        delegate?.view(didSelect: hero)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // fetch more data when user pulls up on cell (> constant)
        if maximumOffset - currentOffset <= 10.0 {
            searchBar.text.flatMap {
                $0.isEmpty ? delegate?.fetch() : delegate?.fetchMore(searchText: $0)
            }
        }
    }
}

// MARK: - SearchListViewDataSourceDelegate implementation

extension SearchListView: SearchListViewDataSourceDelegate {
    
    func dataSourceDidUpdate() {
        reloadData()
    }
}

// MARK: - SearchListViewProtocol implementation

extension SearchListView: SearchListViewProtocol {
    
    func consume(data: [SearchListViewPresentable]?) {
        dataSource?.objects = data
    }
}

// MARK: - SearchListViewSearchBarDelegate implementation

extension SearchListView: SearchListViewSearchBarDelegate {
    
    func searchBarDidChange(text: String) {
        delegate?.fetch(searchText: text)
    }
    
    func searchBarCancelButtonTapped() {
        refetchData()
    }
}
