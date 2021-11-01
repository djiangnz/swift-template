//
//  AuthAction.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import ReSwift

struct AuthActionRenewToken: Action {
    var token = Token()
}

struct AuthActionRemoveToken: Action {
    var token = Token()
}
