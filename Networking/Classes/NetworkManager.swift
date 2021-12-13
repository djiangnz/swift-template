//
//  NetworkManager.swift
//  Networking
//
//  Created by djiang on 22/11/21.
//

import Foundation

public final class NetworkManager {
    public static var shared = NetworkManager()
    public var baseURLString = "https://api.stackexchange.com/2.2"
}
