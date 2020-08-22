//
//  FalseNavigationBarView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/22/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

protocol FalseNavigationBarViewProtocol {
    func addTapGesture(target: Any, action: Selector)
}

final class FalseNavigationBarView: UILabel {

    init(title: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        configure(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with title: String?) {
        self |> navigationItemTextStyle
        isUserInteractionEnabled = true
        text = title
    }
}

extension FalseNavigationBarView: FalseNavigationBarViewProtocol {
    
    func addTapGesture(target: Any, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
}
