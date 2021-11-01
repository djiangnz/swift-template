//
//  CollectionViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public struct CollectionViewModel<Item: Hashable>: Equatable, Hashable {
    public var sections: [CollectionSectionViewModel<Item>]

    public var allItems: [Item] { sections.flatMap { $0.items } }

    public init(sections: [CollectionSectionViewModel<Item>]) {
        self.sections = sections
    }

    public func itemModel(at indexPath: IndexPath) -> Item {
        return section(at: indexPath.section).items[indexPath.item]
    }

    func items(where test: (Item) -> Bool) -> [Item] {
        return sections
            .flatMap { $0.items }
            .filter(test)
    }

    func section(at section: Int) -> CollectionSectionViewModel<Item> {
        return sections[section]
    }

    typealias DiffableSectionType = CollectionSectionViewModel<DiffableItemType>
    typealias DiffableItemType = ExtraIdentifier<Item>

    func snapshot() -> NSDiffableDataSourceSnapshot<DiffableSectionType, DiffableItemType> {
        var snapshot = NSDiffableDataSourceSnapshot<DiffableSectionType, DiffableItemType>()
        snapshot.appendSections(self.diffableSnapshot().sections)
        self.diffableSnapshot().sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        return snapshot
    }
}

private extension CollectionViewModel {
    func diffableSnapshot() -> CollectionViewModel<DiffableItemType> {
        var sections: [DiffableSectionType] = []

        var allUsedSectionIds: Set<CollectionSectionViewModel<Item>> = []
        var allUsedItemIds: Set<Item> = []

        for (sectionIndex, section) in self.sections.enumerated() {
            var newSection = DiffableSectionType(header: section.header, footer: section.footer, id: section.id, items: [])
            if allUsedSectionIds.contains(section) {
                newSection.id = "extra section Id \(sectionIndex)"
            }
            allUsedSectionIds.insert(section)

            for (itemIndex, item) in section.items.enumerated() {
                var newItem = DiffableItemType(value: item)
                if allUsedItemIds.contains(item) {
                    newItem.extraIdentifier = "extra item Id \(sectionIndex) \(itemIndex)"
                }
                allUsedItemIds.insert(item)
                newSection.items.append(newItem)
            }
            sections.append(newSection)
        }

        return CollectionViewModel<DiffableItemType>(sections: sections)
    }
}
