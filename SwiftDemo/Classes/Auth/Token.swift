//
//  Token.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation

struct Token: Codable, Equatable {
    var basicToken: String?
    var isValid = false

    init(basicToken: String? = nil, isValid: Bool = false) {
        self.basicToken = basicToken
        self.isValid = isValid
    }
}
