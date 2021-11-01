//
//  HomeViewState.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import Controls

typealias HomeCollectionViewStateRow = CollectionViewModel<HomeCollectionViewState.Item>

struct HomeCollectionViewState: CollectionViewState {
    enum Item: Hashable {
        case cell1(HomeCollectionCellViewModel)
        case cell2(HomeCollectionCellViewModel)
    }

    let title: String? = "Home"
    let collection: CollectionViewModel<Item>
//    let baseState: BaseViewState
}
