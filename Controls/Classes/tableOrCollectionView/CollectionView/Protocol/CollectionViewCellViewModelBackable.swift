//
//  CollectionViewCellViewModelBackable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol CollectionViewCellViewModelBackable: CollectionViewCellSelfRegisterable {
    associatedtype ViewModelType

    func configure(cellViewModel: ViewModelType)

    static func create(in collectionView: UICollectionView, for indexPath: IndexPath) -> Self
    static func create(in collectionView: UICollectionView, for indexPath: IndexPath, with viewModel: ViewModelType) -> Self
}

public extension CollectionViewCellViewModelBackable {
    static func create(in collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView, willRegister: {
            self.register(in: collectionView)
        })
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selfRegisterableReuseId, for: indexPath) as! Self
        return cell
    }

    static func create(in collectionView: UICollectionView, for indexPath: IndexPath, with viewModel: ViewModelType) -> Self {
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView, willRegister: {
            self.register(in: collectionView)
        })
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selfRegisterableReuseId, for: indexPath) as! Self
        cell.configure(cellViewModel: viewModel)
        return cell
    }
}
