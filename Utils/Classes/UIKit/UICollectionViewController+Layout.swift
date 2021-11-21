//
//  UICollectionViewController+Layout.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UICollectionViewController {
    enum CollectionLayoutType {
        case flow
        case list
    }

    static var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.itemSize = CGSize(width: 200, height: 200)
        return layout
    }()

    static var listLayout: UICollectionViewLayout = {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        return layout
    }()
}
