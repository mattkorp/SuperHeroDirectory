//
//  AppDelegate.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/7/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var searchListRouter: SearchListRouter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let container = Container()
        searchListRouter = SearchListRouter(container: container)
        setupWindow(root: searchListRouter.viewController)

        return true
    }
}

private extension AppDelegate {

    func setupWindow(root: UIViewController) {
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController(root: root)
        window?.makeKeyAndVisible()
    }

    func navigationController(root: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.navigationBar.tintColor = ColorName.darkGrey.color
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorName.darkGrey.color,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]

        return navigationController
    }
}
