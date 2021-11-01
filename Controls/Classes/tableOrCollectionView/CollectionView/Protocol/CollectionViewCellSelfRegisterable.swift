//
//  CollectionViewCellSelfRegisterable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol CollectionViewCellSelfRegisterable: AnyObject {
    static var selfRegisterableReuseId: String { get }

    static func register(in collectionView: UICollectionView)
}

public extension CollectionViewCellSelfRegisterable {
    static var selfRegisterableReuseId: String {
        return String(describing: self)
    }

    static func register(in collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: selfRegisterableReuseId)
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView)
    }
}
