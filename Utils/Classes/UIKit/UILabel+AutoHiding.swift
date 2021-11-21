//
//  UILabel+Exts.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UILabel {
    func setTextOrHideIfEmpty(_ text: String?) {
        if let newText = text, !newText.isEmpty {
            self.text = newText
            isHidden = false
        } else {
            isHidden = true
        }
    }

    func setAttributedTextOrHideIfEmpty(_ attributedText: NSAttributedString?) {
        if let newText = attributedText, newText.length != 0 {
            self.attributedText = newText
            isHidden = false
        } else {
            isHidden = true
        }
    }

    var singleLineWidth: CGFloat {
        guard let text = text else { return 0 }
        guard let font = font else { return 0 }

        return (text as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).width
    }
}
