//
//  UIWindow+KeyWindow.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .filter { $0.isKeyWindow }.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
