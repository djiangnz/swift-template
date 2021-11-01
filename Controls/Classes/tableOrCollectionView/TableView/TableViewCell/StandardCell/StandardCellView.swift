//
//  StandardCellView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit
import Utils

public class StandardCellView: BaseCellView<StandardCellViewModel> {
    public var detailLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    public init() {
        super.init(customView: detailLabel)
    }

    override public func configure(viewModel: StandardCellViewModel) {
        super.configure(viewModel: viewModel)
        detailLabel.setTextOrHideIfEmpty(viewModel.detail)
    }
}
