//
//  CoinCellViewModel.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import Foundation

final class CoinCellViewModel: CoinCellViewModelProtocol {
    let id = UUID()
    let name: String
    let symbol: String
    let priceString: String
    let imageUrl: String

    required init(name: String, symbol: String, priceString: String, imageUrl: String) {
        self.name = name
        self.symbol = symbol
        self.priceString = priceString
        self.imageUrl = imageUrl
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(priceString)
        hasher.combine(symbol)
        hasher.combine(imageUrl)
    }

    static func == (lhs: CoinCellViewModel, rhs: CoinCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

struct AnyCoinCellViewModel: CoinCellViewModelProtocol {
    var name: String
    var symbol: String
    var priceString: String
    var imageUrl: String

    init(name: String, symbol: String, priceString: String, imageUrl: String) {
        self.name = name
        self.symbol = symbol
        self.priceString = priceString
        self.imageUrl = imageUrl
    }

    init<L: CoinCellViewModelProtocol>(_ viewModel: L) {
        self.init(
            name: viewModel.name,
            symbol: viewModel.symbol,
            priceString: viewModel.priceString,
            imageUrl: viewModel.imageUrl
        )
    }
}
