//
//  ExtraIdentifier.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

public struct ExtraIdentifier<T: Hashable>: Hashable {
    var value: T
    var extraIdentifier: String = ""
}
