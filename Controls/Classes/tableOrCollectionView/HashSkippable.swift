//
//  HashSkippable.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Foundation

@propertyWrapper
public struct HashSkippable<Value>: Hashable {
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public func hash(into hasher: inout Hasher) {}

    public static func == (lhs: HashSkippable<Value>, rhs: HashSkippable<Value>) -> Bool {
        return true
    }
}
