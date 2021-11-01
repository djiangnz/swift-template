//
//  Bundle+Prokit.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import Foundation

class BundleControls {}

extension Bundle {
    static var Controls: Bundle {
        Bundle(for: BundleControls.self)
    }
}
