//
//  CoinDetailView.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

final class CoinDetailView: UIView {
    private weak var ivImage: UIImageView?
    private weak var vName: TitleValueView?
    private weak var vSymbol: TitleValueView?
    private weak var vLastPrice: TitleValueView?
    private weak var vHightestPrice: TitleValueView?
    private weak var vLowestPrice: TitleValueView?
    private weak var vUpdatedTime: TitleValueView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    // MARK: - Other

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension CoinDetailView {
    func setUp() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        let stvContent = UIStackView(frame: frame)
        stvContent.axis = .vertical
        stvContent.spacing = 16.0
        stvContent.alignment = .fill
        stvContent.distribution = .fill
        stvContent.translatesAutoresizingMaskIntoConstraints = false
        stvContent.isLayoutMarginsRelativeArrangement = true
        stvContent.layoutMargins = UIEdgeInsets(top: 44.0, left: 16.0, bottom: 16.0, right: 16.0)

        addSubview(stvContent)
        stvContent.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stvContent.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stvContent.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        setUpImageView(in: stvContent)
        setupDataRowViews(in: stvContent)
    }

    func setUpImageView(in stackView: UIStackView) {
        let ivImage = UIImageView()
        ivImage.contentMode = .scaleAspectFit
        ivImage.translatesAutoresizingMaskIntoConstraints = false
        ivImage.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        ivImage.widthAnchor.constraint(equalTo: ivImage.heightAnchor).isActive = true
        ivImage.image = UIImage(systemName: "bitcoinsign.circle")?.withRenderingMode(.alwaysTemplate)
        ivImage.tintColor = .lightGray
        self.ivImage = ivImage

        let stvImageAligment = UIStackView(arrangedSubviews: [ivImage])
        stvImageAligment.axis = .vertical
        stvImageAligment.alignment = .center
        stvImageAligment.distribution = .fill
        stvImageAligment.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(stvImageAligment)
    }

    func setupDataRowViews(in stackView: UIStackView) {
        let vName = TitleValueView(title: "Name")
        vName.translatesAutoresizingMaskIntoConstraints = false
        self.vName = vName

        let vSymbol = TitleValueView(title: "Symbol")
        vSymbol.translatesAutoresizingMaskIntoConstraints = false
        self.vSymbol = vSymbol

        let vLastPrice = TitleValueView(title: "Last price")
        vLastPrice.translatesAutoresizingMaskIntoConstraints = false
        self.vLastPrice = vLastPrice

        let vHightestPrice = TitleValueView(title: "High 24h")
        vHightestPrice.translatesAutoresizingMaskIntoConstraints = false
        self.vHightestPrice = vHightestPrice

        let vLowestPrice = TitleValueView(title: "Low 24")
        vLowestPrice.translatesAutoresizingMaskIntoConstraints = false
        self.vLowestPrice = vLowestPrice

        let vUpdatedTime = TitleValueView(title: "Last updated")
        vUpdatedTime.translatesAutoresizingMaskIntoConstraints = false
        self.vUpdatedTime = vUpdatedTime

        stackView.addArrangedSubview(makeRow(elements: [vSymbol]))
        stackView.addArrangedSubview(makeRow(elements: [vName, vLastPrice]))
        stackView.addArrangedSubview(makeRow(elements: [vHightestPrice, vLowestPrice]))
        stackView.addArrangedSubview(makeRow(elements: [vUpdatedTime]))
    }

    func makeRow(elements: [UIView]) -> UIStackView {
        let stvRow = UIStackView(arrangedSubviews: elements)
        stvRow.axis = .horizontal
        stvRow.spacing = 16.0
        stvRow.alignment = .fill
        stvRow.distribution = .fillEqually
        stvRow.translatesAutoresizingMaskIntoConstraints = false

        return stvRow
    }
}

// MARK: - CoinDetailViewProtocol

extension CoinDetailView: CoinDetailViewProtocol {
    var image: UIImage? {
        get { ivImage?.image }
        set { ivImage?.image = newValue?.withRenderingMode(.alwaysOriginal) }
    }

    var name: String? {
        get { vName?.text }
        set { vName?.text = newValue ?? "-" }
    }

    var symbol: String? {
        get { vSymbol?.text }
        set { vSymbol?.text = newValue ?? "-" }
    }

    var lastPrice: String? {
        get { vLastPrice?.text }
        set { vLastPrice?.text = newValue ?? "-" }
    }

    var hightestPrice: String? {
        get { vHightestPrice?.text }
        set { vHightestPrice?.text = newValue ?? "-" }
    }

    var lowestPrice: String? {
        get { vLowestPrice?.text }
        set { vLowestPrice?.text = newValue ?? "-" }
    }

    var updatedTime: String? {
        get { vUpdatedTime?.text }
        set { vUpdatedTime?.text = newValue ?? "-" }
    }
}
