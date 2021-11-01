//
//  LabelStyling.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit
import Branding

public struct CellStyling: Hashable {
    public var titleFont: UIFont
    public var titleColor: UIColor
    public var subtitleFont: UIFont
    public var subtitleColor: UIColor
    public var customViewFont: UIFont
    public var customViewColor: UIColor
    public var errorFont: UIFont
    public var errorColor: UIColor
    public var descriptionFont: UIFont
    public var descriptionColor: UIColor

    public static var primary: CellStyling {
        return CellStyling(
            titleFont: UIFont.preferredFont(forTextStyle: .body),
            titleColor: UIColor.brand.primaryText,
            subtitleFont: UIFont.preferredFont(forTextStyle: .body),
            subtitleColor: UIColor.brand.secondaryText,
            customViewFont: UIFont.preferredFont(forTextStyle: .caption1),
            customViewColor: UIColor.brand.secondaryText,
            errorFont: UIFont.preferredFont(forTextStyle: .footnote),
            errorColor: UIColor.brand.secondaryText,
            descriptionFont: UIFont.preferredFont(forTextStyle: .body),
            descriptionColor: UIColor.brand.secondaryText
        )
    }

    public static var secondary: CellStyling {
        return CellStyling(
            titleFont: UIFont.preferredFont(forTextStyle: .caption1),
            titleColor: UIColor.brand.secondaryText,

            subtitleFont: UIFont.preferredFont(forTextStyle: .body),
            subtitleColor: UIColor.brand.primaryText,
            customViewFont: UIFont.preferredFont(forTextStyle: .body),
            customViewColor: UIColor.brand.primaryText,
            errorFont: UIFont.preferredFont(forTextStyle: .footnote),
            errorColor: UIColor.brand.secondaryText,
            descriptionFont: UIFont.preferredFont(forTextStyle: .body),
            descriptionColor: UIColor.brand.secondaryText
        )
    }

    public static var bold: CellStyling {
        return CellStyling(
            titleFont: UIFont.preferredFont(forTextStyle: .body).bolded(),
            titleColor: UIColor.brand.primaryText,
            subtitleFont: UIFont.preferredFont(forTextStyle: .body),
            subtitleColor: UIColor.brand.secondaryText,
            customViewFont: UIFont.preferredFont(forTextStyle: .caption1),
            customViewColor: UIColor.brand.secondaryText,
            errorFont: UIFont.preferredFont(forTextStyle: .footnote),
            errorColor: UIColor.brand.secondaryText,
            descriptionFont: UIFont.preferredFont(forTextStyle: .body),
            descriptionColor: UIColor.brand.secondaryText
        )
    }

    public func configure<T>(_ keyPath: WritableKeyPath<CellStyling, T>, is value: T) -> CellStyling {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
