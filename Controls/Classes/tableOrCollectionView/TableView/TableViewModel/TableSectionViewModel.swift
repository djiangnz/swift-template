//
//  TableSectionViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

public struct TableSectionViewModel<Row>: Hashable where Row: Hashable {
    public var id: String?
    public var header: String?
    public var footer: String?

    @HashSkippable
    public var rows: [Row]

    public init(header: String? = nil, footer: String? = nil, id: String? = nil, rows: [Row]) {
        self.header = header
        self.footer = footer
        self.id = id
        self.rows = rows
    }
}
