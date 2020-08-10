//
//  UIView+Autolayout.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

extension UIView {

    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor)])
    }
    
    func pinToSafeAreaTop() {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.topAnchor)])
    }
    
    func pinToSafeAreaBottom() {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.trailingAnchor)])
    }

    func pinToSafeArea() {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: superview.saferAreaLayoutGuide.topAnchor)])
    }

    func pinBottomToSafeArea(to view: UIView) {
        let viewBottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = view.bottomAnchor
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: viewBottomAnchor)]
        )
    }

    func autolayoutHeight(withWidth width: CGFloat) -> CGFloat {
        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = width
        let autolayoutSize = systemLayoutSizeFitting(targetSize,
                                                     withHorizontalFittingPriority: .defaultHigh,
                                                     verticalFittingPriority: .defaultLow)
        return autolayoutSize.height
    }

    var saferAreaLayoutGuide: UILayoutGuide {
        get {
            if #available(iOS 11.0, *) {
                return safeAreaLayoutGuide
            } else {
                return layoutMarginsGuide
            }
        }
    }

    var isIpad: Bool {
        traitCollection.horizontalSizeClass == .regular
    }
}
