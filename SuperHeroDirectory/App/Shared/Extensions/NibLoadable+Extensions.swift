//
//  NibLoadable+Extensions.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

public extension NibLoadable where Self: UIView {
    
    func loadReferenceFromNib() -> Self {
        let view = type(of: self).loadFromNib()
        view.frame = frame
        view.autoresizingMask = autoresizingMask
        view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        view.backgroundColor = backgroundColor
        view.alpha = alpha

        for placeholderConstraint in constraints {
            let firstItem = (placeholderConstraint.firstItem === self) ? view : placeholderConstraint.firstItem
            let secondItem = (placeholderConstraint.secondItem === self) ? view : placeholderConstraint.secondItem

            let constraint = NSLayoutConstraint(
                item: firstItem as Any,
                attribute: placeholderConstraint.firstAttribute,
                relatedBy: placeholderConstraint.relation,
                toItem: secondItem,
                attribute: placeholderConstraint.secondAttribute,
                multiplier: placeholderConstraint.multiplier,
                constant: placeholderConstraint.constant)

            constraint.identifier = placeholderConstraint.identifier
            constraint.shouldBeArchived = placeholderConstraint.shouldBeArchived
            constraint.priority = placeholderConstraint.priority
            constraint.isActive = placeholderConstraint.isActive

            view.addConstraint(constraint)
        }

        return view
    }
}
