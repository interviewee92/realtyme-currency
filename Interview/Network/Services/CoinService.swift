//
//  CurrencyService.swift
//  Interview
//
//  Created by Przemyslaw Szurmak on 29/01/2022.
//

import Foundation

struct CoinService: CoinServiceProtocol {
    func fetchCoins(fiat: String, urlSession: AnyURLSession, userDefaults _: UserDefaults) async throws -> [CoinModelType] {
        let endpoint = Endpoint.coinsMarkets

        var queryParams: [Endpoint.QueryParam] = [
            .order(.marketCap(ascending: false)),
            .page(1),
            .perPage(100),
            .vsCurrency(fiat),
        ]

        if let apiKey = Network.getCoingeckoDemoApiKey() {
            queryParams.append(.apiKey(apiKey))
        }

        let url = try endpoint.getUrl(queryParams: queryParams)

        Logger.log("Loading: \(url.absoluteString)", type: .network)

        let (data, response) = try await urlSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw Network.Error.invalidResponse
        }

        let decoder = Network.getJSONDecoder()

        guard 200 ..< 300 ~= httpResponse.statusCode else {
            if let errorResponse = try? decoder.decode(CoingeckoErrorModel.self, from: data) {
                throw errorResponse.error
            } else if let status = try? decoder.decode(CoingeckoStatusModel.self, from: data) {
                throw Network.Error.status(message: status.status.errorMessage)
            } else {
                throw Network.Error.invalidResponse
            }
        }

        let results = try decoder.decode([Coin].self, from: data)

        return results
    }
}
