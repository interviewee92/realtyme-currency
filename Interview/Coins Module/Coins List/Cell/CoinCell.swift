//
//  CoinCell.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

final class CoinCell: UITableViewCell, CoinCellProtocol {
    private weak var stvContent: UIStackView!
    private weak var ivImage: UIImageView!
    private weak var lblSymbol: UILabel!
    private weak var lblName: UILabel!
    private weak var lblPrice: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    // MARK: CoinCellProtocol

    static let reuseIdentifier = String(describing: CoinCell.self) + "-reuseIdentifier"

    func configure(with data: CoinData) {
        lblSymbol.text = data.symbol.uppercased()
        lblName.text = data.name
        lblPrice.text = data.price.uppercased()
        ivImage.image = data.image?.withRenderingMode(.alwaysOriginal)
    }

    // MARK: Private

    private func setUp() {
        accessoryType = .disclosureIndicator
        setUpContentStackView()
        setUpContentSubviews()
    }

    private func setUpContentStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        contentView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stvContent = stackView
    }

    private func setUpContentSubviews() {
        if stvContent?.superview == nil { return }

        // Coin image
        let ivImage = UIImageView()
        ivImage.contentMode = .scaleAspectFit
        ivImage.translatesAutoresizingMaskIntoConstraints = false
        ivImage.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        ivImage.widthAnchor.constraint(equalTo: ivImage.heightAnchor).isActive = true
        ivImage.image = UIImage(systemName: "bitcoinsign.circle")?.withRenderingMode(.alwaysTemplate)
        ivImage.tintColor = .lightGray
        stvContent.addArrangedSubview(ivImage)
        self.ivImage = ivImage

        // Labels container
        let stvLabels = UIStackView()
        stvLabels.axis = .vertical
        stvLabels.alignment = .fill
        stvLabels.distribution = .fill
        stvLabels.translatesAutoresizingMaskIntoConstraints = false
        stvContent.addArrangedSubview(stvLabels)

        // Coin symbol label
        let lblSymbol = UILabel()
        lblSymbol.textAlignment = .left
        lblSymbol.translatesAutoresizingMaskIntoConstraints = false
        lblSymbol.font = .preferredFont(forTextStyle: .footnote)
        lblSymbol.textColor = .secondaryLabel
        stvLabels.addArrangedSubview(lblSymbol)
        self.lblSymbol = lblSymbol

        // Coin name label
        let lblName = UILabel()
        lblName.textAlignment = .left
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.font = .preferredFont(forTextStyle: .subheadline)
        stvLabels.addArrangedSubview(lblName)
        self.lblName = lblName

        // Coin price label
        let lblPrice = UILabel()
        lblPrice.textAlignment = .right
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lblPrice.font = .preferredFont(forTextStyle: .subheadline)
        stvContent.addArrangedSubview(lblPrice)
        self.lblPrice = lblPrice
    }

    // MARK: Required

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
