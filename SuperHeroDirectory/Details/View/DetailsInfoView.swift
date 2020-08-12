//
//  DetailsInfoView.swift
//  DragonDrive
//
//  Created by Matthew Korporaal on 20.10.19.
//  Copyright © 2019 Korporaal. All rights reserved.
//

import UIKit
import Nuke

// MARK: - DetailsInfoView

final class DetailsInfoView: UIView {

    var presentable: DetailsViewPresentable? {
        didSet { updateUI() }
    }

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var bioTextView: UITextView!
}

// MARK: - private - configure view

private extension DetailsInfoView {

    func setupUI() {
        self |> lightGreyBackgroundStyle
        bioTextView |> lightGreyBackgroundStyle
        nameLabel |> largeDarkMultilineStyle
        bioLabel |> largeDarkMultilineStyle
    }

    func updateUI() {
        guard let presentable = presentable else { return }
        
        nameLabel.text = presentable.name
        bioLabel.text = presentable.nameLabel
        bioTextView.text = presentable.bio
        
        if let path = presentable.imagePath, let url = URL(string: path) {
            let request = ImageRequest(url: url,
                                       processors: [ImageProcessors.Resize(size: imageView.bounds.size)],
                                       priority: .veryHigh)

            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.33),
                                              contentModes: .init(success: .scaleAspectFit,
                                                                  failure: .center,
                                                                  placeholder: .scaleAspectFit)
            )
            Nuke.loadImage(with: request, options: options, into: imageView)
        } else {
            imageView.image = UIImage(named: presentable.noImageName)
        }
    }
}

// MARK: - NibLoadable

extension DetailsInfoView: NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        if !subviews.isEmpty {
            return super.awakeAfter(using: aDecoder)
        }
        return loadReferenceFromNib()
    }
}
