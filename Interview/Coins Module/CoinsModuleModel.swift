//
//  CoinsModuleModel.swift
//  Interview
//
//  Created by interviewee92 on 09/07/2024.
//

import Foundation
import UIKit

enum CoinListSection {
    case main
}

struct FiatData {
    let id: String
    let name: String
    var isSelected: Bool = false
}

struct CoinData: Hashable {
    let name: String
    let symbol: String
    let price: String
    let lowest24hPrice: String
    let highest24hPrice: String
    let lastUpdatedTime: String
    let imageUrlString: String
    var image: UIImage?

    func hash(into hasher: inout Hasher) {
        hasher.combine(lastUpdatedTime)
        hasher.combine(image != nil)
    }
}
