//
//  SearchListViewSearchBar.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/22/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - SearchListViewSearchBarDelegate

protocol SearchListViewSearchBarDelegate: class {
    func searchBarDidChange(text: String)
    func searchBarCancelButtonTapped()
}

final class SearchListViewSearchBar: UISearchBar {

    weak var searchDelegate: SearchListViewSearchBarDelegate?
    
    func configure() {
        delegate = self
        placeholder = L10n.SearchList.Searchbar.Placeholder.text
        showsCancelButton = true
    }
}

// MARK: - UISearchBarDelegate

extension SearchListViewSearchBar: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelegate?.searchBarDidChange(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
        searchDelegate?.searchBarCancelButtonTapped()
    }
    
    func endSearchBarEditing() {
        text = ""
        endEditing(true)
    }
}
