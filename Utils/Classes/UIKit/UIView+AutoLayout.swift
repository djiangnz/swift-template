//
//  UIView+AutoLayout.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIView {
    func forAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
