//
//  TableViewHeaderFooterViewModelBackable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol TableViewHeaderFooterViewModelBackable: TableViewHeaderFooterViewSelfRegisterable {
    associatedtype ViewModelType

    func configure(cellViewModel: ViewModelType)

    static func create(in tableView: UITableView) -> Self
    static func create(in tableView: UITableView, with viewModel: ViewModelType) -> Self
}

public extension TableViewHeaderFooterViewModelBackable {
    static func create(in tableView: UITableView) -> Self {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: selfRegisterableReuseId) ?? {
            register(in: tableView)
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: selfRegisterableReuseId)!
        }()
        // swiftlint:disable:next force_cast
        return view as! Self
    }

    static func create(in tableView: UITableView, with viewModel: ViewModelType) -> Self {
        let view = Self.create(in: tableView)
        view.configure(cellViewModel: viewModel)
        return view
    }
}
