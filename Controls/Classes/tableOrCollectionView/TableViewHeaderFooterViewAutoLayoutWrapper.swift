//
//  TableViewHeaderFooterViewAutoLayoutWrapper.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import UIKit

public class TableHeaderFooterLabel: TableViewHeaderFooterAutoLayoutableView<UILabel> {
    public var text: String? {
        didSet {
            wrappedView.text = text
        }
    }

    public convenience init(text: String?, in tableView: UITableView, insets: UIEdgeInsets = .zero, constrainToMarginOnEdges: UIRectEdge = [.left, .right]) {
        let textLabel = UILabel(frame: .zero)
        textLabel.numberOfLines = 0
        textLabel.text = text
        self.init(wrapping: textLabel, in: tableView, insets: insets, constrainToMarginOnEdges: constrainToMarginOnEdges)
    }
}

public class TableViewHeaderFooterAutoLayoutableView<T: UIView>: UIView {
    public var wrappedView: T

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private weak var tableView: UITableView?
    private var lastFrame: CGRect = .zero

    public init(wrapping view: T, in tableView: UITableView, insets: UIEdgeInsets = .zero, constrainToMarginOnEdges: UIRectEdge = [.left, .right]) {
        self.wrappedView = view
        super.init(frame: .zero)

        self.tableView = tableView
        preservesSuperviewLayoutMargins = true
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: constrainToMarginOnEdges.contains(.right) ? layoutMarginsGuide.trailingAnchor : trailingAnchor, constant: -insets.right),
            view.leadingAnchor.constraint(equalTo: constrainToMarginOnEdges.contains(.left) ? layoutMarginsGuide.leadingAnchor : leadingAnchor, constant: insets.left),
            view.topAnchor.constraint(equalTo: constrainToMarginOnEdges.contains(.top) ? layoutMarginsGuide.topAnchor : topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: constrainToMarginOnEdges.contains(.bottom) ? layoutMarginsGuide.bottomAnchor : bottomAnchor, constant: -insets.bottom).withPriority(999)
        ])

        NotificationCenter.default.addObserver(self, selector: #selector(frameDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        frameDidChange()
    }

    @objc
    private func frameDidChange() {
        guard let tableView = tableView, lastFrame != frame else { return }

        lastFrame = frame
        if self == tableView.tableHeaderView {
            tableView.resizeTableHeaderView()
        } else if self == tableView.tableFooterView {
            tableView.resizeTableFooterView()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITableView {
    func resizeTableHeaderView() {
        guard let tableHeaderView = tableHeaderView else { return }
        tableHeaderView.setNeedsLayout()
        tableHeaderView.layoutIfNeeded()

        let targetSize = CGSize(width: tableHeaderView.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let idealHeaderHeight = tableHeaderView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height

        if tableHeaderView.frame.size.height != idealHeaderHeight {
            tableHeaderView.frame.size.height = idealHeaderHeight
            self.tableHeaderView = tableHeaderView
        }
    }

    func resizeTableFooterView() {
        guard let tableFooterView = tableFooterView else { return }
        tableFooterView.setNeedsLayout()
        tableFooterView.layoutIfNeeded()

        let targetSize = CGSize(
            width: tableFooterView.bounds.size.width,
            height: UIView.layoutFittingCompressedSize.height
        )
        let idealFooterHeight = tableFooterView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height

        if tableFooterView.frame.size.height != idealFooterHeight {
            tableFooterView.frame.size.height = idealFooterHeight
            self.tableFooterView = tableFooterView
        }
    }
}
