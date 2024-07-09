//
//  TitleValueView.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

class TitleValueView: UIView {
    weak var lblTitle: UILabel?
    weak var lblValue: UILabel?

    var text: String? {
        get { lblValue?.text }
        set { lblValue?.text = newValue }
    }

    init(title: String) {
        super.init(frame: .zero)

        setUp(title: title)
    }

    private func setUp(title: String) {
        backgroundColor = .white
        layer.cornerRadius = 8.0
        layer.masksToBounds = true

        let stvContent = UIStackView(frame: frame)
        stvContent.axis = .vertical
        stvContent.spacing = 4.0
        stvContent.alignment = .fill
        stvContent.distribution = .fill
        stvContent.translatesAutoresizingMaskIntoConstraints = false
        stvContent.isLayoutMarginsRelativeArrangement = true
        stvContent.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)

        addSubview(stvContent)
        stvContent.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stvContent.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stvContent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stvContent.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        let lblTitle = UILabel()
        lblTitle.text = title
        lblTitle.textAlignment = .center
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .preferredFont(forTextStyle: .footnote)
        lblTitle.textColor = .secondaryLabel
        stvContent.addArrangedSubview(lblTitle)
        self.lblTitle = lblTitle

        let lblValue = UILabel()
        lblValue.text = "-"
        lblValue.textAlignment = .center
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        lblValue.font = .preferredFont(forTextStyle: .body)
        lblValue.textColor = .black
        stvContent.addArrangedSubview(lblValue)
        self.lblValue = lblValue
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
