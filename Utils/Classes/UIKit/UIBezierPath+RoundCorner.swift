//
//  UIBezierPath+RoundCorner.swift
//  Utils
//
//  Created by djiang on 10/10/21.
//

import UIKit

private enum PathElement {
    case moveToPoint(CGPoint)
    case addLineToPoint(CGPoint)
    case addQuadCurveToPoint(CGPoint, CGPoint)
    case addCurveToPoint(CGPoint, CGPoint, CGPoint)
    case closeSubpath
}

private extension CGPath {
    private class Info {
        var pathElements = [PathElement]()
    }
    
    var pathElements: [PathElement] {
        var info = Info()
        self.apply(info: &info) { info, element -> Void in
            if let infoPointer = UnsafeMutablePointer<Info>(OpaquePointer(info)) {
                switch element.pointee.type {
                case .moveToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(.moveToPoint(pt))
                case .addLineToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(.addLineToPoint(pt))
                case .addQuadCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    infoPointer.pointee.pathElements.append(.addQuadCurveToPoint(pt1, pt2))
                case .addCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    let pt3 = element.pointee.points[2]
                    infoPointer.pointee.pathElements.append(.addCurveToPoint(pt1, pt2, pt3))
                case .closeSubpath:
                    infoPointer.pointee.pathElements.append(.closeSubpath)
                @unknown default:
                    break
                }
            }
        }
        return info.pathElements
    }
}

public extension UIBezierPath {
    struct CornersRadii {
        let topLeft: CGFloat
        let topRight: CGFloat
        let bottomRight: CGFloat
        let bottomLeft: CGFloat
        
        public init(topLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomRight = bottomRight
            self.bottomLeft = bottomLeft
        }
    }

    convenience init(roundedRect rect: CGRect, cornersRadii: CornersRadii) {
        var topLeftCornerPathElements: [PathElement]
        var topRightCornerPathElements: [PathElement]
        var bottomRightCornerPathElements: [PathElement]
        var bottomLeftCornerPathElements: [PathElement]
        
        topLeftCorner: do {
            let cornerRadius = cornersRadii.topLeft <= (min(rect.width, rect.height) / 2) ? cornersRadii.topLeft : min(rect.width, rect.height) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rect = CGRect(origin: rect.origin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            topLeftCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        topRightCorner: do {
            let cornerRadius = cornersRadii.topRight <= (min(rect.width, rect.height) / 2) ? cornersRadii.topRight : min(rect.width, rect.height) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x + rect.size.width - (cornerRadius * 2), y: rect.origin.y)
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            topRightCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .topRight, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        bottomRightCorner: do {
            let cornerRadius = cornersRadii.bottomRight <= (min(rect.width, rect.height) / 2) ? cornersRadii.bottomRight : min(rect.width, rect.height) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x + rect.size.width - (cornerRadius * 2), y: rect.origin.y + rect.size.height - (cornerRadius * 2))
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            bottomRightCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomRight, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        bottomLeftCorner: do {
            let cornerRadius = cornersRadii.bottomLeft <= (min(rect.width, rect.height) / 2) ? cornersRadii.bottomLeft : min(rect.width, rect.height) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - (cornerRadius * 2))
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            bottomLeftCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomLeft, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        let finalRoundedRectPathElements = [
            topLeftCornerPathElements[0],
            topRightCornerPathElements[1],
            topRightCornerPathElements[2],
            topRightCornerPathElements[3],
            topRightCornerPathElements[4],
            topRightCornerPathElements[5],
            bottomRightCornerPathElements[2],
            bottomRightCornerPathElements[3],
            bottomRightCornerPathElements[4],
            bottomRightCornerPathElements[5],
            bottomRightCornerPathElements[6],
            bottomLeftCornerPathElements[3],
            bottomLeftCornerPathElements[4],
            bottomLeftCornerPathElements[5],
            bottomLeftCornerPathElements[6],
            bottomLeftCornerPathElements[7],
            topLeftCornerPathElements[4],
            topLeftCornerPathElements[5],
            topLeftCornerPathElements[6],
            topLeftCornerPathElements[7],
            topLeftCornerPathElements[8],
            PathElement.closeSubpath
        ]
        
        self.init(pathElements: finalRoundedRectPathElements)
    }
    
    fileprivate convenience init(pathElements elements: [PathElement]) {
        self.init(cgPath: UIBezierPath.from(pathElements: elements).cgPath)
    }
    
    fileprivate static func from(pathElements elements: [PathElement]) -> UIBezierPath {
        let mutablePath = CGMutablePath()
        for element in elements {
            switch element {
            case .moveToPoint(let point):
                mutablePath.move(to: point)
            case .addLineToPoint(let point):
                mutablePath.addLine(to: point)
            case .addCurveToPoint(let control1, let control2, let point):
                mutablePath.addCurve(to: point, control1: control1, control2: control2)
            case .addQuadCurveToPoint(let point, let control):
                mutablePath.addQuadCurve(to: point, control: control)
            case .closeSubpath:
                mutablePath.closeSubpath()
            }
        }
        return UIBezierPath(cgPath: mutablePath)
    }
}
