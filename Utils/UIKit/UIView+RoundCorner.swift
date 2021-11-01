//
//  UIView+RoundCorner.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public enum RoundType {
    case none
    case top
    case bottom
    case all
}

public extension UIView {
    func roundCorners(cornerRadius: CGFloat, type: RoundType = .all) {
        var corners: UIRectCorner

        switch type {
        case .none:
            corners = []
        case .top:
            corners = [.topLeft, .topRight]
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .all:
            corners = [.allCorners]
        }

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
