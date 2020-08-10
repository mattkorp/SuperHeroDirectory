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
    
//    private var presentable: DetailsViewPresentable?

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
//        self.presentable = presentable
//        title = L10n.Details.Navigation.title(presentables[0].flight.outbound.route.destination)
        DispatchQueue.main.async {
            self.detailsInfoView.presentable = presentable
        }
    }
}

//// MARK: - DetailsViewUIDataSource - implementation
//
//extension DetailsViewController: DetailsViewDataSource {
//    // Pass data to data source
//    func object() -> [DetailsViewPresentable]? {
//        presentables
//    }
//}
