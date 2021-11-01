//
//  LibManager.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import CocoaLumberjack
import IQKeyboardManagerSwift
import Rswift
import SDWebImage
import SnapKit
import UIKit

class LibManager {
    static let shared = LibManager()

    var fileLogger: DDFileLogger!

    func setupLibs(with window: UIWindow? = nil) {
        let libManager = LibManager.shared
        libManager.setupCocoaLumberjack()
        libManager.setupKeyboardManager()
        libManager.setupSDWebImage()
    }

    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        fileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24) // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        fileLogger.logFormatter = LogFormatter()
        DDLog.add(fileLogger)

        DDLogVerbose("Start Running")
        print(fileLogger.logFileManager.logsDirectory)
    }

    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    func setupSDWebImage() {
        SDWebImageDownloader.shared.config.downloadTimeout = 15
    }
}
