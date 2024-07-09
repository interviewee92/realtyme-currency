//
//  NetworkService.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

enum Endpoint {
    case currencies
    case coinsMarkets

    private var scheme: String {
        "https"
    }

    private var host: String {
        switch self {
        case .currencies:
            return "api.coinbase.com"
        case .coinsMarkets:
            return "api.coingecko.com"
        }
    }

    private var apiVersion: String {
        switch self {
        case .currencies:
            return "v2"
        case .coinsMarkets:
            return "api/v3"
        }
    }

    private var path: String {
        switch self {
        case .currencies:
            return "currencies"
        case .coinsMarkets:
            return "coins/markets"
        }
    }

    func getUrl(queryParams: [QueryParam] = []) throws -> URL {
        let components = NSURLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/" + [apiVersion, path].joined(separator: "/")

        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { $0.asUrlQueryItem() }
        }

        guard let url = components.url else {
            throw Network.Error.invalidUrl
        }

        return url
    }
}

extension Endpoint {
    enum QueryParam {
        case order(FetchOrder)
        case page(Int)
        case perPage(Int)
        case vsCurrency(String)
        case apiKey(String)

        func asUrlQueryItem() -> URLQueryItem {
            switch self {
            case let .order(value):
                return .init(name: "order", value: value.description)
            case let .page(value):
                return .init(name: "page", value: "\(value)")
            case let .perPage(value):
                return .init(name: "per_page", value: "\(value)")
            case let .vsCurrency(value):
                return .init(name: "vs_currency", value: value)
            case let .apiKey(value):
                return .init(name: "x_cg_demo_api_key", value: value)
            }
        }
    }

    enum FetchOrder: CustomStringConvertible {
        case marketCap(ascending: Bool)
        case volume(ascending: Bool)
        case id(ascending: Bool)

        var description: String {
            switch self {
            case let .marketCap(ascending):
                return "market_cap_" + (ascending ? "asc" : "desc")
            case let .volume(ascending):
                return "volume_" + (ascending ? "asc" : "desc")
            case let .id(ascending):
                return "id_" + (ascending ? "asc" : "desc")
            }
        }
    }
}
