//
//  UserRepository.swift
//  Networking
//
//  Created by djiang on 10/10/21.
//

import Alamofire
import Controls
import Foundation
import Models

public class UserRepository: Repository {
    public static func getUserList(success: @escaping (UserList) -> Void) {
        NetworkClient.get(api: UserApi.users, type: UserList.self, success: success)
    }
}
