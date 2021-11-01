//
//  BaseCellView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit
import Branding

private enum Constants {
    public static let defaultEdgeInset = Spacing.default
    public static let defaultSpacing = Spacing.default
    public static let defaultLargeSpacing = Spacing.large
    public static let defaultIconSize: CGFloat = 40
    public static let lowerRequired = UILayoutPriority(999.0)
}

public class BaseCellView<ViewModelType: BaseCellViewModelType>: UIView {
    public var layoutInsets = UIEdgeInsets(top: Constants.defaultEdgeInset, left: Constants.defaultLargeSpacing, bottom: Constants.defaultEdgeInset, right: Constants.defaultLargeSpacing) {
        didSet {
            mainStackView.directionalLayoutMargins = .init(top: layoutInsets.top, leading: layoutInsets.left, bottom: layoutInsets.bottom, trailing: layoutInsets.right)
        }
    }

    public var hasSeparator: Bool = true

    private var customView: UIView?

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.spacing = Constants.defaultSpacing
        view.directionalLayoutMargins = .zero
        return view
    }()

    private lazy var bodyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = Constants.defaultSpacing
        view.distribution = .fill
        return view
    }()

    private lazy var bodyTextsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = Constants.defaultLargeSpacing
        view.distribution = .equalCentering
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .green
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: Constants.defaultIconSize).withPriority(Constants.lowerRequired).isActive = true
        return view
    }()

    private lazy var bodyTitlesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.numberOfLines = 0
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.numberOfLines = 0
        return view
    }()

    private lazy var explanationLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.numberOfLines = 0
        return view
    }()

    private lazy var errorLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.numberOfLines = 0
        return view
    }()

    override public func didMoveToSuperview() {
        guard let superview = self.superview else { return }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }

    public init(customView: UIView? = nil) {
        super.init(frame: .infinite)
        translatesAutoresizingMaskIntoConstraints = false
        preservesSuperviewLayoutMargins = true
        insetsLayoutMarginsFromSafeArea = false

        addSubview(mainStackView)
        mainStackView.addArrangedSubview(bodyStackView)
        mainStackView.addArrangedSubview(errorLabel)
        mainStackView.addArrangedSubview(explanationLabel)

        bodyStackView.addArrangedSubview(iconImageView)
        bodyStackView.addArrangedSubview(bodyTextsStackView)

        bodyTextsStackView.addArrangedSubview(bodyTitlesStackView)
        bodyTitlesStackView.addArrangedSubview(titleLabel)
        bodyTitlesStackView.addArrangedSubview(subtitleLabel)

        if let customView = customView {
            self.customView = customView
            bodyTextsStackView.addArrangedSubview(customView)
        }

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(viewModel: ViewModelType) {
        mainStackView.directionalLayoutMargins = .init(top: layoutInsets.top, leading: layoutInsets.left, bottom: layoutInsets.bottom, trailing: layoutInsets.right)
        iconImageView.setImageOrHideIfEmpty(viewModel.icon)
        titleLabel.setTextOrHideIfEmpty(viewModel.title)
        subtitleLabel.setTextOrHideIfEmpty(viewModel.subtitle)
        explanationLabel.setTextOrHideIfEmpty(viewModel.explanation)
        errorLabel.setTextOrHideIfEmpty(viewModel.errorMessage)

        titleLabel.textColor = viewModel.cellStyling.titleColor
        titleLabel.font = viewModel.cellStyling.titleFont
        titleLabel.numberOfLines = viewModel.titleNumberOfLines

        subtitleLabel.textColor = viewModel.cellStyling.subtitleColor
        subtitleLabel.font = viewModel.cellStyling.subtitleFont
        subtitleLabel.numberOfLines = viewModel.subtitleNumberOfLines

        if let customView = customView as? UILabel {
            customView.textColor = viewModel.cellStyling.customViewColor
            customView.font = viewModel.cellStyling.customViewFont
        }

        bodyTitlesStackView.isHidden = !bodyTitlesStackView.arrangedSubviews.contains(where: { !$0.isHidden })
    }
}
