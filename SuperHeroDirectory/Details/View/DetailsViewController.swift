//
//  DetailsView.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 10/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import UIKit

// MARK: DetailsViewControllerProtocol

protocol DetailsViewControllerProtocol: BaseViewProtocol {
    // Update UI with value returned.
    /// Set the view Object of Type DetailsEntity
    func consume(presentable: DetailsViewPresentable)
}

// MARK: - DetailsView Module View

final class DetailsViewController: BaseViewController {
    
    var presenter: DetailsPresenterProtocol!
    var detailsInfoView: DetailsInfoView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsInfoView = DetailsInfoView.loadFromNib()
        view.addSubview(detailsInfoView)
        detailsInfoView.pinToSafeArea()
        presenter.fetch()
    }
}

// MARK: - DetailsViewControllerProtocol - implementation

extension DetailsViewController: DetailsViewControllerProtocol {

    func consume(presentable: DetailsViewPresentable) {
        title = presentable.name
        DispatchQueue.main.async {
            self.detailsInfoView.presentable = presentable
        }
    }
}
