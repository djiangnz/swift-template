//
//  Auth.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import KeychainAccess
import ReSwift

class AuthManager {
    static let shared = AuthManager()

    fileprivate let tokenKey = "TokenKey"
    fileprivate let keychain = Keychain()

    var token: Token? {
        get {
            guard let jsonData = try? keychain.getData(tokenKey) else { return nil }
            return try? JSONDecoder().decode(Token.self, from: jsonData)
        }
        set {
            if let token = newValue, let data = try? JSONEncoder().encode(token) {
                try? keychain.set(data, key: tokenKey)
            } else {
                try? keychain.remove(tokenKey)
            }
        }
    }

    var hasToken: Bool {
        if let basicToken = token?.basicToken, token?.isValid == true {
            return !basicToken.isEmpty
        }
        return false
    }

    class func setToken(token: Token) {
        store.dispatch(AuthActionRemoveToken(token: token))
    }

    class func removeToken() {
        store.dispatch(AuthActionRemoveToken())
    }

    init() { store.subscribe(self) { $0.select { $0.authState }.skip(when: ==) } }

    deinit { store.unsubscribe(self) }
}

extension AuthManager: StoreSubscriber {
    func newState(state: AuthState) {
        print(state)
        token = state.token
    }
}
