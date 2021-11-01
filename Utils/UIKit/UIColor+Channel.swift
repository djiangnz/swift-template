//
//  UIColor+Channel.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

public extension UIColor {
    /// Calculates the pythagorean distance to another color.
    func distance(to color: UIColor) -> CGFloat {
        let red = pow(self.red - color.red, 2.0)
        let green = pow(self.green - color.green, 2.0)
        let blue = pow(self.blue - color.blue, 2.0)
        let alpha = pow(self.alpha - color.alpha, 2.0)
        
        return sqrt(red + green + blue + alpha)
    }
    
    /// The color's red component.
    private var red: CGFloat {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
    
    /// The color's green component.
    private var green: CGFloat {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }
    
    /// The color's blue component.
    private var blue: CGFloat {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
    
    /// The color's alpha component.
    private var alpha: CGFloat {
        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }
}
