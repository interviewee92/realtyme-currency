//
//  CryptoModel.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

struct Coin: Codable, CoinModelType {
    var id: String
    var name: String
    var symbol: String
    var currentPrice: Double
    var high24H: Double
    var low24H: Double
    var image: String
    var lastUpdated: Date
}
