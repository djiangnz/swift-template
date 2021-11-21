//
//  BundleTests.swift
//  SwiftDemoTests
//
//  Created by djiang on 10/11/21.
//

import Foundation

class BundleTests {}

extension Bundle {
    static var Tests: Bundle {
        Bundle(for: BundleTests.self)
    }
}
