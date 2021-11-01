//
//  CollectionViewHeaderFooterViewViewModelBackable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol CollectionViewHeaderFooterViewViewModelBackable: CollectionViewHeaderFooterViewSelfRegisterable {
    associatedtype ViewModelType

    func configure(cellViewModel: ViewModelType)

    static func create(in collectionView: UICollectionView, ofKind: String, for indexPath: IndexPath) -> Self
    static func create(in collectionView: UICollectionView, ofKind: String, for indexPath: IndexPath, from viewModel: ViewModelType) -> Self
}

public extension CollectionViewHeaderFooterViewViewModelBackable {
    static func create(in collectionView: UICollectionView, ofKind: String, for indexPath: IndexPath) -> Self {
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView, willRegister: {
            self.register(in: collectionView, ofKind: ofKind)
        })
        // swiftlint:disable:next force_cast
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: selfRegisterableReuseId, for: indexPath) as! Self
        return view
    }

    static func create(in collectionView: UICollectionView, ofKind: String, for indexPath: IndexPath, from viewModel: ViewModelType) -> Self {
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView, willRegister: {
            self.register(in: collectionView, ofKind: ofKind)
        })
        // swiftlint:disable:next force_cast
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: selfRegisterableReuseId, for: indexPath) as! Self
        view.configure(cellViewModel: viewModel)
        return view
    }
}
