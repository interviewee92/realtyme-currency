//
//  MockServices.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

@testable import Interview
import UIKit

class MockImageService: ImageServiceProtocol {
    func fetchImageData(url _: URL) async throws -> UIImage? {
        return UIImage()
    }
}

class MockImageManager: ImageManagerProtocol {
    let imageService: ImageServiceProtocol

    required init(imageService: any Interview.ImageServiceProtocol) {
        self.imageService = imageService
    }

    func getImage(for _: String) -> UIImage? {
        return UIImage()
    }

    func downloadAndCacheImage<T>(item: T, key _: String, urlString _: String, completion: @escaping (T, UIImage?) -> Void) where T: Hashable {
        completion(item, UIImage())
    }

    func cancelImageDownload(for _: String) {}
}

class MockCoinService: CoinServiceProtocol {
    func fetchCoins(
        fiat _: String,
        urlSession _: any Interview.AnyURLSession,
        userDefaults _: UserDefaults
    ) async throws -> [any Interview.CoinModelType] {
        [
            Coin(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "btc",
                currentPrice: 208_342,
                high24H: 212_592,
                low24H: 199_520,
                image: "image",
                lastUpdated: Date()
            ),
        ]
    }
}

class MockFiatService: FiatServiceProtocol {
    func fetchFiats(urlSession _: any AnyURLSession) async throws -> [any FiatModelType]
    {
        [
            Fiat(
                id: "AED",
                name: "United Arab Emirates Dirham",
                minSize: "0.01"
            ),
        ]
    }
}
