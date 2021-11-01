//
//  BundleNetworking.swift
//  Networking
//
//  Created by djiang on 10/10/21.
//

import Foundation

class BundleNetworking {}

extension Bundle {
    static var Networking: Bundle {
        Bundle(for: BundleNetworking.self)
    }
}
