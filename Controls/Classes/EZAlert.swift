//
//  EZAlert.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit
import Utils

public enum EZAlert {
    public static func presentError(title: String? = "Error",
                                    message: String,
                                    actions: [UIAlertAction]? = [UIAlertAction(title: "OK", style: .default)])
    {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }

        UIWindow.keyWindow?.rootViewController?.present(alertController, animated: true)
    }
}
