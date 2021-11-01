//
//  HomeCell1.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Controls
import UIKit
import Utils

struct HomeCollectionCellViewModel: Hashable {
    let title: String
}

final class HomeCollectionCell1: UICollectionViewCell, CollectionViewCellViewModelBackable {
    typealias ViewModelType = HomeCollectionCellViewModel

    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.brand.background
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()

    func configure(cellViewModel: ViewModelType) {
        textLabel.text = cellViewModel.title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)

        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
