//
//  CellRegistry.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public enum CellRegistry {
    static var register = NSMapTable<UIView, NSMutableSet>(keyOptions: .weakMemory, valueOptions: .strongMemory)

    static func hasRegistered(identifier: String, in view: UIView) -> Bool {
        return register.object(forKey: view)?.contains(identifier) == true
    }

    static func register(identifier: String, in view: UIView) {
        let registeredIds = register.object(forKey: view) ?? NSMutableSet()
        registeredIds.add(identifier)
        register.setObject(registeredIds, forKey: view)
    }

    static func registerIfNeeded(identifier: String, in view: UIView, willRegister: (() -> Void) = {}, didRegister: (() -> Void) = {}) {
        guard !Self.hasRegistered(identifier: identifier, in: view) else { return }
        willRegister()
        Self.register(identifier: identifier, in: view)
        didRegister()
    }
}
