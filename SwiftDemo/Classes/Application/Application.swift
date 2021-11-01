//
//  Application.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Foundation
import UIKit
import Branding
import Networking
import Models

final class Application {
    static let shared = Application()

    var window: UIWindow!
    let authManager: AuthManager

    init() {
        self.authManager = AuthManager.shared
    }

    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        self.window.backgroundColor = UIColor.brand.background

        if let user = User.currentUser() {
            print(user)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UserRepository.getUserList { userList in
                store.dispatch(HomeActionAddItems(items: userList.users.map { $0.displayName }))
            }
        }

        let loggedIn = authManager.hasToken
        var vc: UIViewController
        if loggedIn {
            vc = UINavigationController(rootViewController: HomeCollectionViewController())
        } else {
            vc = UINavigationController(rootViewController: HomeViewController())
        }

        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }

    func logout() {
        AuthManager.removeToken()
//        let vc = LoginViewController()
//        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//            self.window.rootViewController = vc
//        }, completion: nil)
    }
}
