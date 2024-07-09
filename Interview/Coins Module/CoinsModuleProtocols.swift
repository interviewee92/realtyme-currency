//
//  CoinsModule.swift
//  Interview
//
//  Created by interviewee92 on 09/07/2024.
//

import UIKit

// MARK: - Coins list

protocol CoinsViewProtocol: UIView {
    var tableView: UITableView! { get }
    func setError(message: String?)
}

protocol CoinsViewModelProtocol {
    var errorPublisher: Published<String?>.Publisher { get }
    var cryptoDataPublisher: Published<[CoinData]>.Publisher { get }
    var fiatDataPublisher: Published<[FiatData]>.Publisher { get }
    var selectedFiat: String { get }

    func start()
    func selectFiat(_ symbol: String)

    func viewDidAppear()
    func userDidSelectItem(at indexPath: IndexPath)
    func viewWillShowItem(at indexPath: IndexPath)
    func viewDidHideItem(at indexPath: IndexPath)
}

protocol CoinCellProtocol: UITableViewCell {
    static var reuseIdentifier: String { get }

    func configure(with: CoinData)
}

protocol CoinCellViewModelProtocol: Hashable {
    var name: String { get }
    var symbol: String { get }
    var priceString: String { get }
    var imageUrl: String { get }

    init(name: String, symbol: String, priceString: String, imageUrl: String)
}

// MARK: - Coin details

protocol CoinDetailViewProtocol: UIView {
    var image: UIImage? { get set }
    var name: String? { get set }
    var symbol: String? { get set }
    var lastPrice: String? { get set }
    var hightestPrice: String? { get set }
    var lowestPrice: String? { get set }
    var updatedTime: String? { get set }
}

protocol CoinDetailViewModelProtocol {
    var dataPublisher: Published<CoinData>.Publisher { get }
    var coinData: CoinData { get set }

    init(coinData: CoinData)

    func start()
}
