//
//  DiffableTableViewController.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit
import Branding

open class DiffableTableViewController<ViewModel, ViewState>: UITableViewController where ViewModel: AbstractTableViewModel<ViewState>, ViewState: TableViewState {
    override public init(style: UITableView.Style) {
        super.init(style: .plain)
        setupTableView()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private typealias DiffableSectionType = TableSectionViewModel<ExtraIdentifier<ViewState.Row>>
    private typealias DiffableRowType = ExtraIdentifier<ViewState.Row>
    private typealias DataSource = UITableViewDiffableDataSource<DiffableSectionType, DiffableRowType>

    private class TableViewDiffableDataSource: DataSource {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            guard itemIdentifier(for: IndexPath(row: .zero, section: section)) != nil else { return nil }
            return snapshot().sectionIdentifiers[section].header
        }

        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            guard itemIdentifier(for: IndexPath(row: .zero, section: section)) != nil else { return nil }
            return snapshot().sectionIdentifiers[section].footer
        }
    }

    private lazy var dataSource = makeDataSource()

    open var viewModel: ViewModel!

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.background
        applySnapshot(animatingDifferences: false)
    }

    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectRow(indexPath: indexPath)
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(_:cellForRowAt:) not implemented in \(String(describing: type(of: self)))")
    }
}

extension DiffableTableViewController {
    open func applySnapshot(animatingDifferences: Bool = true) {
        DispatchQueue.main.async {
            self.dataSource.apply(self.viewModel.viewState.table.snapshot(), animatingDifferences: animatingDifferences)
        }
    }
}

extension DiffableTableViewController {
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = 40
        tableView.backgroundColor = .clear
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
    }

    private func makeDataSource() -> DataSource {
        let dataSource = TableViewDiffableDataSource(tableView: self.tableView, cellProvider: { [weak self] tabelView, indexPath, _ -> UITableViewCell? in
            self?.tableView(tabelView, cellForRowAt: indexPath)
        })
        return dataSource
    }
}
