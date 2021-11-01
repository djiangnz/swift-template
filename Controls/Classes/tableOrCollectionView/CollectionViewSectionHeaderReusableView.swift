//
//  CollectionViewSectionHeaderReusableView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

final class CollectionViewSectionHeaderReusableView: UICollectionReusableView, CollectionViewHeaderFooterViewViewModelBackable {
    func configure(cellViewModel: String) {}

    typealias ViewModelType = String

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = .label
        view.textAlignment = .left
        view.numberOfLines = 1
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5)
            ])
        } else {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
