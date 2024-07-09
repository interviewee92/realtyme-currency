//
//  CurrencyService.swift
//  Interview
//
//  Created by Przemyslaw Szurmak on 29/01/2022.
//

import Foundation

struct FiatService: FiatServiceProtocol {
    func fetchFiats(urlSession: AnyURLSession) async throws -> [FiatModelType] {
        let url = try Endpoint.currencies.getUrl()

        Logger.log("Loading: \(url.absoluteString)", type: .network)

        let (data, _) = try await urlSession.data(from: url)

        let decoder = Network.getJSONDecoder()
        let result = try decoder.decode(DataArrayResponse<Fiat>.self, from: data)

        return result.data
    }
}
