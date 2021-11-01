//
//  PaddingLabel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

// https://stackoverflow.com/a/58876988/5357508

import UIKit

open class PaddingLabel: UILabel {
    open var insets: UIEdgeInsets = .zero {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }

    override open var intrinsicContentSize: CGSize {
        numberOfLines = 0
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += insets.top + insets.bottom
        intrinsicContentSize.width += insets.left + insets.right
        return intrinsicContentSize
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines n: Int) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: 0)
    }
}
