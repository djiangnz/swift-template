//
//  TableViewHeaderFooterViewSelfRegisterable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol TableViewHeaderFooterViewSelfRegisterable: UITableViewHeaderFooterView {
    static var selfRegisterableReuseId: String { get }

    static func register(in tableView: UITableView)
}

public extension TableViewHeaderFooterViewSelfRegisterable {
    static var selfRegisterableReuseId: String {
        return String(describing: self)
    }

    static func register(in tableView: UITableView) {
        tableView.register(self, forHeaderFooterViewReuseIdentifier: selfRegisterableReuseId)
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: tableView)
    }
}
