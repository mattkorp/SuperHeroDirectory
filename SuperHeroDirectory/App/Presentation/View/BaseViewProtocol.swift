//
//  BaseViewProtocol.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - BaseViewProtocol - declaration
/// The base protocol for all view protocols. Contains the common functions
protocol BaseViewProtocol: class {
    /// Show a loading view in the view controller
    func startLoading()
    /// Dismiss the loading view from the view controller
    func stopLoading()
    /// Shows an activity alert
    func showAlert(title: String, message: String, buttonTitle: String, completion: (() -> Void)?)
}

// MARK: - BaseViewProtocol - implementation
// default implementation constrained to VC's that subclass BaseViewController
extension BaseViewProtocol where Self: BaseViewController {

    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

    func showAlert(title: String = "",
                   message: String = "",
                   buttonTitle: String = "",
                   completion: (() -> Void)? = nil) {
        showAlertController(title: title, message: message, buttonTitle: buttonTitle, completion: completion)
    }
}
