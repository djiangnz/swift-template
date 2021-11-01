//
//  AppDelegate+Push.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import UIKit
import UserNotifications

extension AppDelegate {
    func registerRemotePushNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
            debugPrint(granted ? "success" : "failure")
        }
    }

    func getNotificationAuthorizationStatus() -> UNAuthorizationStatus {
        var status: UNAuthorizationStatus = .notDetermined
        let sema = DispatchSemaphore(value: 0)
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            status = setting.authorizationStatus
            sema.signal()
        }
        _ = sema.wait(timeout: DispatchTime.now() + 0.5)
        return status
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.list, .sound])
        } else {
            completionHandler([.alert, .sound])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
