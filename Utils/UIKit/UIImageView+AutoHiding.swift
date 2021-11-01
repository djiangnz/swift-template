//
//  UIImageView+AutoHiding.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIImageView {
    func setImageOrHideIfEmpty(_ image: UIImage?) {
        if let newImage = image {
            self.image = newImage
            isHidden = false
        } else {
            isHidden = true
        }
    }
}
