//
//  StandardCellViewModel.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public struct StandardCellViewModel: BaseCellViewModelType, Hashable {
    public var title: String?
    public var subtitle: String?
    public var icon: UIImage?
    
    public var detail: String?

    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var explanation: String?
    public var errorMessage: String?

    public var hasSeparator: Bool = true
    public var cellStyling: CellStyling = .primary

    public func configure<T>(_ keyPath: WritableKeyPath<StandardCellViewModel, T>, is value: T) -> StandardCellViewModel {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }

    public static func standard(title: String, subtitle: String? = nil, detail: String? = nil, icon: UIImage? = nil, accessoryType: UITableViewCell.AccessoryType = .none, explanation: String? = nil, errorMessage: String? = nil) -> StandardCellViewModel {
        var model = StandardCellViewModel(title: title, subtitle: subtitle, icon: icon, detail: detail, accessoryType: accessoryType, explanation: explanation, errorMessage: errorMessage)
        model.styleForStandardTitle()
        return model
    }

    public static func smallTitle(title: String, subtitle: String? = nil, detail: String? = nil, icon: UIImage? = nil, accessoryType: UITableViewCell.AccessoryType = .none, explanation: String? = nil, errorMessage: String? = nil) -> StandardCellViewModel {
        var model = StandardCellViewModel(title: title, subtitle: subtitle, icon: icon, detail: detail, accessoryType: accessoryType, explanation: explanation, errorMessage: errorMessage)
        model.styleForSmallTitle()
        return model
    }

    public static func boldTitle(title: String, subtitle: String? = nil, detail: String? = nil, icon: UIImage? = nil, accessoryType: UITableViewCell.AccessoryType = .none, explanation: String? = nil, errorMessage: String? = nil) -> StandardCellViewModel {
        var model = StandardCellViewModel(title: title, subtitle: subtitle, icon: icon, detail: detail, accessoryType: accessoryType, explanation: explanation, errorMessage: errorMessage)
        model.styleForBoldTitle()
        return model
    }

    public mutating func styleForStandardTitle() {
        cellStyling = .primary
    }

    public mutating func styleForSmallTitle() {
        cellStyling = .secondary
    }

    public mutating func styleForBoldTitle() {
        cellStyling = .bold
    }
}
