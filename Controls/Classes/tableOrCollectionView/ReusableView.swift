//
//  ReusableView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}

public extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        CellRegistry.registerIfNeeded(identifier: T.defaultReuseIdentifier, in: self)
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
}

extension UITableViewCell: ReusableView {}

public extension UITableView {
    func dequeue<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        CellRegistry.registerIfNeeded(identifier: T.defaultReuseIdentifier, in: self)
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
}
