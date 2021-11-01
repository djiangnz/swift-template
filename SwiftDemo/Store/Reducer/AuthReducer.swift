//
//  AuthReducer.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import ReSwift

func authReducer(action: Action, state: AuthState?) -> AuthState {
    var state = state ?? AuthState()

    switch action {
    case let copy as AuthActionRenewToken:
        state.token = copy.token
    default: break
    }
    return state
}
