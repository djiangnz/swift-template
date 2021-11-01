//
//  CollectionViewHeaderFooterViewSelfRegisterable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol CollectionViewHeaderFooterViewSelfRegisterable: AnyObject {
    static var selfRegisterableReuseId: String { get }

    static func register(in collectionView: UICollectionView, ofKind: String)
}

public extension CollectionViewHeaderFooterViewSelfRegisterable {
    static var selfRegisterableReuseId: String {
        return String(describing: self)
    }

    static func register(in collectionView: UICollectionView, ofKind: String = UICollectionView.elementKindSectionHeader) {
        collectionView.register(self, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: selfRegisterableReuseId)
        CellRegistry.registerIfNeeded(identifier: selfRegisterableReuseId, in: collectionView)
    }
}
