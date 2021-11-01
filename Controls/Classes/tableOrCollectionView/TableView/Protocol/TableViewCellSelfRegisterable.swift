//
//  TableViewCellSelfRegisterable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol TableViewCellSelfRegisterable: AnyObject {
    static var selfRegisterableReuseId: String { get }

    static func register(in tableView: UITableView)
}

public extension TableViewCellSelfRegisterable {
    static var selfRegisterableReuseId: String {
        return String(describing: self)
    }

    static func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: selfRegisterableReuseId)
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: tableView)
    }
}
