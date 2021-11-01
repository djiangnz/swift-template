//
//  CollectionViewState.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

public protocol CollectionViewState {
    associatedtype Item: Hashable

    var title: String? { get }
    var collection: CollectionViewModel<Item> { get }
//    var baseState: BaseViewState { get }
}
