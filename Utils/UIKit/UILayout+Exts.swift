//
//  UILayoutExts.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension NSLayoutConstraint {
    @discardableResult
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(rawValue: Float(value))
    }
}
