//
//  HomeViewState.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import Controls

typealias HomeViewStateRow = TableViewModel<HomeViewState.Row>

struct HomeViewState: TableViewState {
    enum Row: Hashable {
        case cell1(StandardCellViewModel)
    }

    let title: String? = "Home"
    let table: TableViewModel<Row>
//    let baseState: BaseViewState
}
