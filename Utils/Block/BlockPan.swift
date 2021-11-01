//
//  BlockPan.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

#if os(iOS) || os(tvOS)

/// Make sure you use "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
open class BlockPan: UIPanGestureRecognizer {
    private var panAction: ((UIPanGestureRecognizer) -> Void)?

    override public init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(action: ((UIPanGestureRecognizer) -> Void)?) {
        self.init()
        self.panAction = action
        self.addTarget(self, action: #selector(BlockPan.didPan(_:)))
    }

    @objc
    open func didPan(_ pan: UIPanGestureRecognizer) {
        panAction?(pan)
    }
}

#endif
