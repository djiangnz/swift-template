//
//  CollectionSectionViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

public struct CollectionSectionViewModel<Item>: Hashable where Item: Hashable {
    public var id: String?
    public var header: String?
    public var footer: String?

    @HashSkippable
    public var items: [Item]
    
    public init(header: String? = nil, footer: String? = nil, id: String? = nil, items: [Item]) {
        self.header = header
        self.footer = footer
        self.id = id
        self.items = items
    }
}
