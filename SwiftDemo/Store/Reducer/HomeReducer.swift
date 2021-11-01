//
//  HomeReducer.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import ReSwift

func homeReducer(action: Action, state: HomeState?) -> HomeState {
    var state = state ?? HomeState()

    switch action {
    case let copy as HomeActionAddItems:
        state.menuTitles.append(contentsOf: copy.items)
    case let copy as HomeActionUpdateSearch:
        let menuTitles = state.menuTitles
        state.isSearching = copy.isSearching
        guard copy.isSearching, let query = copy.query, !query.isEmpty else { state.filteredTitles = []; break }
        let matchedTitles = menuTitles.filter { title in
            title.lowercased().contains(query.lowercased())
        }
        state.filteredTitles = matchedTitles
    default: break
    }
    return state
}
