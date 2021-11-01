//
//  TableViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public struct TableViewModel<Row: Hashable>: Equatable, Hashable {
    public var sections: [TableSectionViewModel<Row>]

    public var allRows: [Row] { sections.flatMap { $0.rows } }

    public init(sections: [TableSectionViewModel<Row>]) {
        self.sections = sections
    }

    public func rowModel(at indexPath: IndexPath) -> Row {
        return section(at: indexPath.section).rows[indexPath.row]
    }

    func rows(where test: (Row) -> Bool) -> [Row] {
        return sections
            .flatMap { $0.rows }
            .filter(test)
    }

    func section(at section: Int) -> TableSectionViewModel<Row> {
        return sections[section]
    }

    typealias DiffableSectionType = TableSectionViewModel<ExtraIdentifier<Row>>
    typealias DiffableRowType = ExtraIdentifier<Row>

    func snapshot() -> NSDiffableDataSourceSnapshot<DiffableSectionType, DiffableRowType> {
        var snapshot = NSDiffableDataSourceSnapshot<DiffableSectionType, DiffableRowType>()
        snapshot.appendSections(self.diffableSnapshot().sections)
        self.diffableSnapshot().sections.forEach { section in
            snapshot.appendItems(section.rows, toSection: section)
        }
        return snapshot
    }
}

private extension TableViewModel {
    func diffableSnapshot() -> TableViewModel<DiffableRowType> {
        var sections: [DiffableSectionType] = []

        var allUsedSectionIds: Set<TableSectionViewModel<Row>> = []
        var allUsedItemIds: Set<Row> = []

        for (sectionIndex, section) in self.sections.enumerated() {
            var newSection = DiffableSectionType(header: section.header, footer: section.footer, id: section.id, rows: [])
            if allUsedSectionIds.contains(section) {
                newSection.id = "extra section Id \(sectionIndex)"
            }
            allUsedSectionIds.insert(section)

            for (rowIndex, item) in section.rows.enumerated() {
                var newItem = DiffableRowType(value: item)
                if allUsedItemIds.contains(item) {
                    newItem.extraIdentifier = "extra row Id \(sectionIndex) \(rowIndex)"
                }
                allUsedItemIds.insert(item)
                newSection.rows.append(newItem)
            }
            sections.append(newSection)
        }
        
        return TableViewModel<ExtraIdentifier<Row>>(sections: sections)
    }
}
