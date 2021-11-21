//
//  UserList.swift
//  Models
//
//  Created by djiang on 10/10/21.
//

import Foundation

public struct UserList: Codable {
    public let users: [User]
    public let has_more: Bool

    enum CodingKeys: String, CodingKey {
        case users = "items"
        case has_more
    }
}

public struct BadgeCounts: Codable {
    let bronze: Int
    let silver: Int
    let gold: Int

    enum CodingKeys: String, CodingKey {
        case bronze
        case silver
        case gold
    }
}

public struct User: Codable {
    public let displayName: String
    public let reputation: Double
    public let badgeCounts: BadgeCounts

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case reputation
        case badgeCounts = "badge_counts"
    }
}
