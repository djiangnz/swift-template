//
//  HomeAction.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import ReSwift

struct HomeActionAddItems: Action {
    let items: [String]
}

struct HomeActionUpdateSearch: Action {
    let isSearching: Bool
    let query: String?
}
