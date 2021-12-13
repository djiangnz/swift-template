//
//  DebuggerViewController.swift
//  Debugging
//
//  Created by djiang on 22/11/21.
//

import UIKit

public extension UIViewController {
    enum DebugMenu {
        case open
        case close

        public var keyCommand: UIKeyCommand {
            switch self {
            case .open:
                return UIKeyCommand(input: "d", modifierFlags: .command, action: #selector(didPressKey(keyCommand:)))
            case .close:
                return UIKeyCommand(input: "d", modifierFlags: .command, action: #selector(dismissDebugMenuKeyboardShortcutTriggered))
            }
        }
    }

    @objc
    func didPressKey(keyCommand: UIKeyCommand) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = "Debug"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.addKeyCommand(DebugMenu.close.keyCommand)
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true, completion: nil)
    }

    @objc
    func dismissDebugMenuKeyboardShortcutTriggered() {
        dismiss(animated: true, completion: nil)
    }
}
