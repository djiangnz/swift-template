//
//  TableViewState.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

public protocol TableViewState {
    associatedtype Row: Hashable

    var title: String? { get }
    var table: TableViewModel<Row> { get }
}
