//
//  Functions.swift
//  SwiftDemoTests
//
//  Created by djiang on 10/10/21.
//
import UIKit

public func configure<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}
