//
//  Debouncer.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import Foundation

@available(iOS 10, tvOS 10, *)
public class Debouncer {
    public static let shared = Debouncer()

    private var defalutTimeInterval: TimeInterval
    private weak var timer: Timer?

    public init(timeInterval: TimeInterval = 1.0) {
        self.defalutTimeInterval = timeInterval
    }

    public func run(timeInterval: TimeInterval? = nil, _ callback: @escaping (() -> Void)) {
        let dueTime = timeInterval ?? defalutTimeInterval
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: dueTime, repeats: false) { _ in
            callback()
        }
    }
}
