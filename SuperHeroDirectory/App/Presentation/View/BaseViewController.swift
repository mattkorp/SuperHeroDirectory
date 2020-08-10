//
//  BaseViewController.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: - BaseViewController - common functionality

open class BaseViewController: UIViewController, BaseViewProtocol {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.color = ColorName.darkGrey.color
        activityView.center = view.center
        view.addSubview(activityView)

        return activityView
    }()

    func showAlertController(title: String,
                             message: String,
                             buttonTitle: String,
                             completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let button = buttonTitle.isEmpty ? L10n.General.Alert.Ok.title : buttonTitle
            alert.addAction(.init(title: button, style: .destructive, handler: { _ in completion?() }))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
