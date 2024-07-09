//
//  NetworkModelProtocols.swift
//  Interview
//
//  Created by interviewee92 on 09/07/2024.
//

import UIKit

protocol FiatModelType {
    var id: String { get }
    var name: String { get }
    var minSize: String? { get }
}

protocol CoinModelType {
    var id: String { get }
    var name: String { get }
    var symbol: String { get }
    var currentPrice: Double { get }
    var high24H: Double { get }
    var low24H: Double { get }
    var image: String { get }
    var lastUpdated: Date { get }
}
