//
//  GradientView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

class GradientView: UIView {
    var startColor: UIColor = .blue {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }

    var endColor: UIColor = .red {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }

    var locations: [CGFloat] = [0, 1] {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }

    private var gradient: CGGradient?

    private func updateGradient() {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        gradient = CGGradient(colorsSpace: colorSpace,
                              colors: [startColor.cgColor, endColor.cgColor] as CFArray,
                              locations: locations)
    }

    override func draw(_ rect: CGRect) {
        if gradient == nil {
            updateGradient()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 0, y: bounds.size.height)
        context.drawLinearGradient(gradient!, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    }
}
