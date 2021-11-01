//
//  DiffableCollectionViewController.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

open class DiffableCollectionViewController<ViewModel, ViewState>: UICollectionViewController where ViewModel: AbstractCollectionViewModel<ViewState>, ViewState: CollectionViewState {
    public convenience init(collectionLayoutType: CollectionLayoutType = .flow) {
        let layout = collectionLayoutType == .flow ? Self.flowLayout : Self.listLayout
        self.init(collectionViewLayout: layout)
    }

    override public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.brand.background
        collectionView.alwaysBounceVertical = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
    }

    typealias DiffableSectionType = CollectionSectionViewModel<DiffableItemType>
    typealias DiffableItemType = ExtraIdentifier<ViewState.Item>
    typealias DataSource = UICollectionViewDiffableDataSource<DiffableSectionType, DiffableItemType>

    private class CollectionViewDiffableDataSource: DataSource {}

    private lazy var dataSource = makeDataSource()

    open var viewModel: ViewModel!

    open func applySnapshot(animatingDifferences: Bool = true) {
        DispatchQueue.main.async {
            self.dataSource.apply(self.viewModel.viewState.collection.snapshot(), animatingDifferences: animatingDifferences) {}
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        applySnapshot(animatingDifferences: false)
    }

    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(indexPath: indexPath)
    }

    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("collectionView(_:cellForItemAt:) not implemented in \(String(describing: type(of: self)))")
    }
}

extension DiffableCollectionViewController {
    private func makeDataSource() -> DataSource {
        let dataSource = CollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, _ in
            guard let self = self else { return nil }
            return self.collectionView(collectionView, cellForItemAt: indexPath)
        })
        return dataSource
    }
}
