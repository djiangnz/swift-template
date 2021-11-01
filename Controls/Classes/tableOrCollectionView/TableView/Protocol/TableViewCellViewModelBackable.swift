//
//  TableViewCellViewModelBackable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol TableViewCellViewModelBackable: TableViewCellSelfRegisterable {
    associatedtype ViewModelType

    func configure(cellViewModel: ViewModelType)

    static func create(in tableView: UITableView) -> Self
    static func create(in tableView: UITableView, with viewModel: ViewModelType) -> Self
}

public extension TableViewCellViewModelBackable {
    static func create(in tableView: UITableView) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: selfRegisterableReuseId) ?? {
            register(in: tableView)
            return tableView.dequeueReusableCell(withIdentifier: selfRegisterableReuseId)!
        }()
        // swiftlint:disable:next force_cast
        return cell as! Self
    }

    static func create(in tableView: UITableView, with viewModel: ViewModelType) -> Self {
        let cell = Self.create(in: tableView)
        cell.configure(cellViewModel: viewModel)
        return cell
    }
}
