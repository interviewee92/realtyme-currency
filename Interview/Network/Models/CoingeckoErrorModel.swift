//
//  File.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import Foundation

struct CoingeckoErrorModel: Codable {
    var error: CoingeckoError

    enum CoingeckoError: String, Codable, LocalizedError {
        case invalidCurrency = "invalid vs_currency"

        var errorDescription: String? {
            switch self {
            case .invalidCurrency:
                return "Selected currency is not supported"
            }
        }
    }
}

struct CoingeckoStatusModel: Codable {
    var status: CoingeckoStatusErrorModel
}

struct CoingeckoStatusErrorModel: Codable {
    var errorMessage: String
}
