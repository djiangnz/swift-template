//
//  Optional+Exts.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import Foundation

public extension Swift.Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}

public extension Swift.Optional where Wrapped == NSAttributedString {
    var isEmptyOrNil: Bool {
        if self == nil || self?.length == 0 {
            return true
        }
        return false
    }
}

public extension Swift.Optional where Wrapped: Collection {
    var isEmptyOrNil: Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }
}
