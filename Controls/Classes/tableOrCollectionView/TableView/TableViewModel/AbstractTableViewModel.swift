//
//  AbstractTableViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation
import UIKit

open class AbstractTableViewModel<ViewState: TableViewState> {
    open var viewState: ViewState!

    public init() {}

    open func selectRow(indexPath: IndexPath) {
        fatalError("selectRow not implemented")
    }

    open func buildViewState(_ state: Any) -> ViewState {
        fatalError("buildViewState not implemented")
    }
}
