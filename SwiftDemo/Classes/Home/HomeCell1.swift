//
//  HomeCell1.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Controls
import UIKit
import Utils

struct HomeCellViewModel: Hashable {
    let title: String
}

final class HomeCell1: UITableViewCell, TableViewCellViewModelBackable {
    typealias ViewModelType = HomeCellViewModel

    func configure(cellViewModel: ViewModelType) {
        textLabel?.text = cellViewModel.title + cellViewModel.title
        self.imageView?.image = R.image.images()
        self.addGestureRecognizer(BlockTap(action: { _ in
            print(cellViewModel.title)
        }))
    }

    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
