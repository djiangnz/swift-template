//
//  UIEdgeInsets+Init.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIEdgeInsets {
    init(allSides inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// Helper for inline creating a copy with an exception to UIEdgeInsets
    /// eg. `separatorInsets = layoutMargins.except(.left, is: 16.0)`
    func except(_ keyPath: WritableKeyPath<UIEdgeInsets, CGFloat>, is newValue: CGFloat) -> UIEdgeInsets {
        return except([keyPath], are: newValue)
    }

    /// Helper for inline creating a copy with an exception to UIEdgeInsets
    /// eg. `separatorInsets = layoutMargins.except([.left, .right], are: 16.0)`
    func except(_ keyPaths: [WritableKeyPath<UIEdgeInsets, CGFloat>], are newValue: CGFloat) -> UIEdgeInsets {
        var copy = self
        for keyPath in keyPaths {
            copy[keyPath: keyPath] = newValue
        }
        return copy
    }
}
