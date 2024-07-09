//
//  CoinDetailViewModel.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import Foundation

final class CoinDetailViewModel: CoinDetailViewModelProtocol {
    var dataPublisher: Published<CoinData>.Publisher { $_coinData }

    var coinData: CoinData {
        get { _coinData }
        set { _coinData = newValue }
    }

    @Published private var _coinData: CoinData

    required init(coinData data: CoinData) {
        _coinData = data
    }

    func start() {}
}
