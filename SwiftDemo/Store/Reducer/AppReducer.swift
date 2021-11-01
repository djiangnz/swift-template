//
//  AppReducer.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        authState: authReducer(action: action, state: state?.authState),
        homeState: homeReducer(action: action, state: state?.homeState)
    )
}
