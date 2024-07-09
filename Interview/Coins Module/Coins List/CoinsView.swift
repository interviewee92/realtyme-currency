//
//  CoinsView.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import UIKit

final class CoinsView: UIView, CoinsViewProtocol {
    fileprivate(set) weak var tableView: UITableView!
    private weak var lblError: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    func setError(message: String?) {
        tableView.isHidden = !(message ?? "").isEmpty
        lblError.isHidden = !tableView.isHidden
        lblError.text = message
    }

    // MARK: - Private

    private func setUp() {
        backgroundColor = .white

        setUpErrorLabel()
        setUpTableView()
    }

    private func setUpErrorLabel() {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        addSubview(label)

        let margin: CGFloat = 16.0
        label.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true

        lblError = label
    }

    private func setUpTableView() {
        let tableView = UITableView(frame: frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        self.tableView = tableView
    }

    // MARK: - Other

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
