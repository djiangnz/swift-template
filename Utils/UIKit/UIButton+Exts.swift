//
//  UIButton+Exts.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIButton {
    func setTrailingImage(_ image: UIImage?, for controlState: UIControl.State) {
        // Buttons can have trailng images if you force RightToLeft semantics, neat right?
        semanticContentAttribute = .forceRightToLeft
        setImage(image, for: .normal)
    }

    func setSpacingBetweenTitleAndImage(_ spacing: CGFloat) {
        if semanticContentAttribute == .forceRightToLeft {
            imageEdgeInsets.left = spacing
            imageEdgeInsets.right = -spacing
        } else {
            titleEdgeInsets.left = spacing
            titleEdgeInsets.right = -spacing
        }
    }
}
