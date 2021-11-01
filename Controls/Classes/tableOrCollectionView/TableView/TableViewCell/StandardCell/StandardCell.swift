//
//  StandardCell.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public final class StandardCell: UITableViewCell, TableViewCellViewModelBackable {
    public typealias ViewModelType = StandardCellViewModel

    public var cellView = StandardCellView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func configure(cellViewModel viewModel: ViewModelType) {
        cellView.configure(viewModel: viewModel)
        accessoryType = viewModel.accessoryType
    }
}
