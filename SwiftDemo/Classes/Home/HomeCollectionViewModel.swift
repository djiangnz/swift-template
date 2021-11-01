//
//  HomeViewModel.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Controls
import Foundation
import UIKit

private typealias Section = CollectionSectionViewModel<HomeCollectionViewState.Item>
private typealias Item = HomeCollectionViewState.Item

class HomeCollectionViewModel: AbstractCollectionViewModel<HomeCollectionViewState> {
    override init() {
        super.init()
        self.viewState = HomeCollectionViewState(collection: .init(sections: []))
    }

    func buildViewState(_ state: HomeState) -> HomeCollectionViewState {
        var sections: [Section] = []
        sections.append(section1(state))
        return HomeCollectionViewState(collection: .init(sections: sections))
    }

    fileprivate func section1(_ state: HomeState) -> Section {
        var section = Section(items: [])
        section.header = "section1 header"
        section.footer = "section1 footer"
        if state.isSearching {
            for item in state.filteredTitles {
                section.items.append(.cell1(HomeCollectionCellViewModel(title: item)))
            }
        } else {
            for item in state.menuTitles {
                section.items.append(.cell1(HomeCollectionCellViewModel(title: item)))
            }
        }

        return section
    }

    override func selectItem(indexPath: IndexPath) {
        select(item: viewState.collection.itemModel(at: indexPath))
    }

    private func select(item: Item) {
        switch item {
        case .cell1:
            print("cell1")
        case .cell2:
            print("cell2")
        }
    }
}
