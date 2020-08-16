//
//  SearchListView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: SearchListViewControllerProtocol

protocol SearchListViewControllerProtocol: BaseViewProtocol {
    // Update UI with value returned.
    /// Set the view Object of view model
    func consume(presentables: [SearchListViewPresentable])
    /// Show alert if failure
    func show(title: String, message: String)
}

// MARK: - SearchListView Module View

final class SearchListViewController: BaseViewController {
    
    var presenter: SearchListPresenterProtocol!

    private let searchListView = SearchListView()
    private var presentables: [SearchListViewPresentable]?
    private var isLoadingMore = false

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle
    
    override func loadView() {
        searchListView.delegate = self
        searchListView.dataSource = self
        view = searchListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.SearchList.Navigation.title
        presenter.fetch()
        tapLabelToScrollToTheTop()
    }
}

// MARK: - OverviewViewControllerProtocol - implementation

extension SearchListViewController: SearchListViewControllerProtocol {

    func consume(presentables: [SearchListViewPresentable]) {
        isLoadingMore = false
        
        self.presentables = self.presentables.flatMap { $0 + presentables } ?? presentables
        searchListView.reloadData()
    }

    func show(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

// MARK: - OverviewViewUIDelegate - implementation

extension SearchListViewController: SearchListViewUIDelegate {
    
    func fetch(searchText: String) {
        presentables = nil
        presenter.fetch(startsWith: searchText)
    }
    
    func fetchMore(searchText: String) {
        presenter.fetchMore(startsWith: searchText)
    }
    
    func fetch() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        presenter.fetch()
    }

    func refresh() {
        presentables = nil
        presenter.refresh()
    }

    func view(didSelect presentable: SearchListViewPresentable) {
        presenter.view(didSelect: presentable)
    }
}

// MARK: - SearchListViewUIDataSource - implementation

extension SearchListViewController: SearchListViewDataSource {
    // Pass data to data source
    func object() -> [SearchListViewPresentable]? { presentables }
}

extension SearchListViewController {
    /// Set gesture recognizer to scroll to top of list if nav bar is tapped
    func tapLabelToScrollToTheTop() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        label.text = navigationItem.title
        label |> navigationItemTextStyle
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGestureRecognizer)
        label.isUserInteractionEnabled = true
        navigationItem.titleView = label
    }
        
    @objc
    func labelTapped(_ sender: UITapGestureRecognizer) {
        searchListView.scrollToTop()
    }
}
