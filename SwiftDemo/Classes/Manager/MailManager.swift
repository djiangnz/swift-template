//
//  MailManager.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import CocoaLumberjack
import Foundation
import MessageUI

struct Attachment {
    let data: Data
    let mimeType: String = "text/plain"
    let filename: String
}

class MailManager: NSObject, MFMailComposeViewControllerDelegate {
    weak var fromVC: UIViewController?

    var toRecipients: [String] = ["djiangnz@gmail.com"]
    var subject: String = "Log of ***"
    var messageBody: String = "messageBody"
    var attachment: Attachment?

    var logFilesAttachment: Attachment? {
        let logFilePaths = LibManager.shared.fileLogger.logFileManager.sortedLogFilePaths
        var logFileDataArray = [NSData]()
        var attachmentData = Data()

        for logFilePath in logFilePaths {
            let fileURL = NSURL(fileURLWithPath: logFilePath)
            guard let logFileData = try? NSData(contentsOf: fileURL as URL, options: .mappedIfSafe) else { continue }
            logFileDataArray.insert(logFileData, at: 0)
        }

        if logFileDataArray.isEmpty { return nil }

        for logFileData in logFileDataArray { attachmentData.append(logFileData as Data) }

        return Attachment(data: attachmentData, filename: "aaa.log")
    }

    func sendApplicationLogViaEmail() {
        guard let logFilesAttachment = logFilesAttachment else { return }
        attachment = logFilesAttachment
        sendMail()
    }

    func sendMail() {
        guard MFMailComposeViewController.canSendMail(), let fromVC = fromVC else { return }

        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self

        controller.setToRecipients(toRecipients)
        controller.setSubject(subject)
        controller.setMessageBody(messageBody, isHTML: false)

        if let attachment = attachment {
            controller.addAttachmentData(attachment.data, mimeType: attachment.mimeType, fileName: attachment.filename)
        }

        fromVC.present(controller, animated: true, completion: nil)
    }
}
