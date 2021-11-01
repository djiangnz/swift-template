//
//  HomeViewModel.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import UIKit
import Controls

private typealias Section = TableSectionViewModel<HomeViewState.Row>
private typealias Row = HomeViewState.Row

class HomeViewModel: AbstractTableViewModel<HomeViewState> {
    override init() {
        super.init()
        self.viewState = HomeViewState(table: .init(sections: []))
    }

    func buildViewState(_ state: HomeState) -> HomeViewState {
        var sections: [Section] = []
        sections.append(section1(state))
        return HomeViewState(table: .init(sections: sections))
    }

    fileprivate func section1(_ state: HomeState) -> Section {
        var section = Section(rows: [])

        for item in state.menuTitles {
            section.rows.append(.cell1(StandardCellViewModel.standard(title: item, detail: item, icon: R.image.images())))
        }

        return section
    }

    override func selectRow(indexPath: IndexPath) {
        select(row: viewState.table.rowModel(at: indexPath))
    }

    private func select(row: Row) {
        switch row {
        case .cell1:
            print("cell1")
        }
    }
}
