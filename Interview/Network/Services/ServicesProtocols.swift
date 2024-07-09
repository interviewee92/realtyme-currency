//
//  ServiceProtocols.swift
//  Interview
//
//  Created by interviewee92 on 09/07/2024.
//

import UIKit

// MARK: - Genral

protocol AnyURLSession {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: AnyURLSession {}

// MARK: - Fetching fiat currencies

protocol FiatServiceProtocol {
    func fetchFiats(urlSession: AnyURLSession) async throws -> [FiatModelType]
}

extension FiatServiceProtocol {
    func fetchFiats() async throws -> [FiatModelType] {
        try await fetchFiats(urlSession: URLSession.shared)
    }
}

// MARK: - Fetching crypto currencies

protocol CoinServiceProtocol {
    func fetchCoins(fiat: String, urlSession: AnyURLSession, userDefaults: UserDefaults) async throws -> [CoinModelType]
}

extension CoinServiceProtocol {
    func fetchCoins(fiat: String) async throws -> [CoinModelType] {
        try await fetchCoins(fiat: fiat, urlSession: URLSession.shared, userDefaults: .standard)
    }
}

// MARK: - Fetching images

protocol ImageServiceProtocol {
    func fetchImageData(url: URL) async throws -> UIImage?
}

protocol ImageManagerProtocol {
    init(imageService: ImageServiceProtocol)
    func getImage(for key: String) -> UIImage?
    func downloadAndCacheImage<T: Hashable>(item: T, key: String, urlString: String, completion: @escaping (T, UIImage?) -> Void)
    func cancelImageDownload(for key: String)
}
