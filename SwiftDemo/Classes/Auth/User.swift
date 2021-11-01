//
//  User.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import KeychainAccess

private let userkey = "User.CurrentUserKey"

struct User: Codable {
    let id: Int
    let username: String
    let name: String
}

extension User {
    static func currentUser() -> User? {
        if let jsonData = try? Keychain().getData(userkey),
           let user = try? JSONDecoder().decode(User.self, from: jsonData)
        {
            return user
        }
        return nil
    }

    static func removeCurrentUser() {
        try? Keychain().remove(userkey)
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try Keychain().set(data, key: userkey)
        } catch {
            print("User can't be saved")
        }
    }

    func isMe() -> Bool {
        return self == User.currentUser()
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
