//
//  UserApi.swift
//  Networking
//
//  Created by djiang on 10/10/21.
//

import Alamofire
import Foundation

public enum UserApi: URLRequestConvertible {
    case users

    static let baseURLString = "https://api.stackexchange.com/2.2"

    public func asURLRequest() throws -> URLRequest {
        let path: String

        switch self {
        case .users:
            path = "/users?order=desc&sort=reputation&site=stackoverflow"
        }

        let url = URL(string: UserApi.baseURLString + path)!

        return URLRequest(url: url)
    }
}
