//
//  HomeState.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import ReSwift

struct HomeState: Equatable {
    var menuTitles: [String]
    var filteredTitles: [String]
    var isSearching: Bool

    init() {
        menuTitles = []
        filteredTitles = []
        isSearching = false
    }
}
