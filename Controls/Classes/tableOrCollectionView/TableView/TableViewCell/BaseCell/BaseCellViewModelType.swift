//
//  BaseCellViewModelType.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public protocol BaseCellViewModelType: Equatable {
    var icon: UIImage? { get }
    var title: String? { get }
    var titleNumberOfLines: Int { get }
    var subtitle: String? { get }
    var subtitleNumberOfLines: Int { get }
    var accessoryType: UITableViewCell.AccessoryType { get }
    var errorMessage: String? { get }
    var explanation: String? { get }
    var cellStyling: CellStyling { get }
}

public extension BaseCellViewModelType {
    var icon: UIImage? { return nil }
    var titleNumberOfLines: Int { return 0 }
    var subtitle: String? { return nil }
    var subtitleNumberOfLines: Int { return 0 }
    var accessoryType: UITableViewCell.AccessoryType { return .none }
    var errorMessage: String? { return nil }
    var explanation: String? { return nil }
    var cellStyling: CellStyling { return .primary }
}
