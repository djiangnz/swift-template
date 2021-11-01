//
//  UIFont+Traits.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import Foundation
import UIKit

public extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: 0) // size 0 means keep the size as it is
    }

    func bolded() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italicised() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

    static func scaledSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: size))
    }
}
