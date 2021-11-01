//
//  BrandColor.swift
//  Branding
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIColor {
    static let brand = Brand.self

    enum Brand {
        public static let primary: UIColor = dynamicColor(light: UIColor(hex: 0x0770e3), dark: UIColor(hex: 0x6d9feb))
        public static let background: UIColor = dynamicColor(light: .white, dark: .black)
        public static let secondaryBackground: UIColor = dynamicColor(light: UIColor(hex: 0xf1f2f8), dark: UIColor(hex: 0x1d1b20))
        public static let tertiaryBackground: UIColor = dynamicColor(light: .white, dark: UIColor(hex: 0x2c2c2e))

        public static let line: UIColor = dynamicColor(light: UIColor(hex: 0xcdcdd7), dark: UIColor(hex: 0x48484a))

        public static let primaryText: UIColor = dynamicColor(light: UIColor(hex: 0x111236), dark: .white)
        public static let secondaryText: UIColor = dynamicColor(light: UIColor(hex: 0x68697f), dark: UIColor(hex: 0x8e8e93))
        public static let tertiaryText: UIColor = dynamicColor(light: UIColor(hex: 0x8f90a0), dark: UIColor(hex: 0x8e8e93))
        public static let quaternaryText: UIColor = dynamicColor(light: UIColor(hex: 0xb2b2bf), dark: UIColor(hex: 0x8e8e93))
    }

    private static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor {
            if #available(iOS 13.0, *) {
                return $0.userInterfaceStyle == .dark ? dark : light
            }
            return light
        }
    }
}

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
