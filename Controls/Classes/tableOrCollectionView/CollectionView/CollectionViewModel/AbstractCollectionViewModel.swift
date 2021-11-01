//
//  AbstractCollectionViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

open class AbstractCollectionViewModel<ViewState: CollectionViewState> {
    open var viewState: ViewState!

    public init() {}

    open func selectItem(indexPath: IndexPath) {
        fatalError("selectRow not implemented")
    }

    open func buildViewState(_ state: Any) -> ViewState {
        fatalError("buildViewState not implemented")
    }
}
