//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Controls
import ReSwift
import UIKit
import Networking
import Utils
import Debugging

class HomeViewController: DiffableTableViewController<HomeViewModel, HomeViewState> {
    init(viewModel: HomeViewModel = HomeViewModel()) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyCommand(DebugMenu.open.keyCommand)
        view.backgroundColor = UIColor.brand.background
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { $0.select { $0.homeState }.skip(when: ==) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowModel = viewModel.viewState.table.rowModel(at: indexPath)
        switch rowModel {
        case .cell1(let cellViewModel):
            return StandardCell.create(in: tableView, with: cellViewModel)
        }
    }
}

extension HomeViewController: StoreSubscriber {
    func newState(state: HomeState) {
        self.viewModel.viewState = viewModel.buildViewState(state)
        self.applySnapshot()
    }
}
