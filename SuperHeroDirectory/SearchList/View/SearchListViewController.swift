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
        title = "Superhero Directory" // L10n.Overview.Navigation.title
        presenter.fetch()
    }
}

// MARK: - OverviewViewControllerProtocol - implementation

extension SearchListViewController: SearchListViewControllerProtocol {

    func consume(presentables: [SearchListViewPresentable]) {
        isLoadingMore = false
        
        if let old = self.presentables {
            self.presentables = old + presentables
        } else {
            self.presentables = presentables
        }
       
        DispatchQueue.main.async {
            self.searchListView.reloadData()
        }
    }

    func show(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

// MARK: - OverviewViewUIDelegate - implementation

extension SearchListViewController: SearchListViewUIDelegate {

    func fetch() {
        if !isLoadingMore {
            isLoadingMore = true
            presenter.fetch()
        }
    }


    func refresh() {
        presenter.refresh()
    }

    func view(didSelect presentable: SearchListViewPresentable) {
        presenter.view(didSelect: presentable)
    }
}

// MARK: - SearchListViewUIDataSource - implementation

extension SearchListViewController: SearchListViewDataSource {
    // Pass data to data source
    func object() -> [SearchListViewPresentable]? {
        presentables
    }
}
