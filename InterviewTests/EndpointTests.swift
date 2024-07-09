//
//  EndpointTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 07/07/2024.
//

@testable import Interview
import XCTest

final class EndpointTests: XCTestCase {
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testCurrenciesEndpointURL() throws {
        do {
            let url = try Endpoint.currencies.getUrl()
            XCTAssertEqual(url.absoluteString, "https://api.coinbase.com/v2/currencies")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCoinsMarketsEndpointURL() throws {
        do {
            let url = try Endpoint.coinsMarkets.getUrl()
            XCTAssertEqual(url.absoluteString, "https://api.coingecko.com/api/v3/coins/markets")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCoinsMarketsEndpointURLWithQueryItems() throws {
        do {
            let queryItems: [Endpoint.QueryParam] = [
                .vsCurrency("usd"),
                .order(.marketCap(ascending: false)),
                .perPage(30),
                .page(1),
            ]

            let url = try Endpoint.coinsMarkets.getUrl(queryParams: queryItems)

            let expectedUrlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1"
            XCTAssertEqual(url.absoluteString, expectedUrlString)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCoinsMarketsEndpointURLWithQueryItemsAndApiKey() throws {
        do {
            let queryItems: [Endpoint.QueryParam] = [
                .vsCurrency("usd"),
                .order(.marketCap(ascending: false)),
                .perPage(30),
                .page(1),
                .apiKey("mockApiKey"),
            ]

            let url = try Endpoint.coinsMarkets.getUrl(queryParams: queryItems)

            let expectedUrlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1&x_cg_demo_api_key=mockApiKey"
            XCTAssertEqual(url.absoluteString, expectedUrlString)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
