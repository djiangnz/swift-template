//
//  LogManager.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import CocoaLumberjack
import Foundation

class LogFormatter: DDDispatchQueueLogFormatter {
    let dateFormatter: DateFormatter

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        super.init()
    }

    override func format(message logMessage: DDLogMessage) -> String {
        let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
        return "\(dateAndTime) [\(logMessage.fileName):\(logMessage.line)]: \(logMessage.message)"
    }
}
