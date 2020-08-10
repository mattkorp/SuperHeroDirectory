//
//  SearchListView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit
import Nuke

// MARK: SearchListViewUIDelegate

protocol SearchListViewUIDelegate {
    /// Returns selected superhero viewmodel to view
    func view(didSelect presentable: SearchListViewPresentable)
    /// Fetch data from endpoint
    func fetch()
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
    private let tableView = TableView()
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
        addSubview(tableView)
        tableView.configure(delegate: self, dataSource: self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.refreshControl?.addTarget(self, action: #selector(refetchData), for: .valueChanged)
    }

    func setupConstraints() {
        tableView.pinToSafeArea()
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

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            delegate?.fetch()
        }
    }
}
