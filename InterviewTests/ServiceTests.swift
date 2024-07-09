//
//  ServiceTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

@testable import Interview
import XCTest

final class ServiceTests: XCTestCase {
    func testCoinServiceCorrectResponse() async throws {
        let service = CoinService()
        let userDefaults = MockUserDefaults()
        let session = MockURLSession(json: .coins)

        let expectation = expectation(description: "Coins are parsed and retured")

        let task = Task {
            let results = try await service.fetchCoins(fiat: "usd", urlSession: session, userDefaults: userDefaults)
            XCTAssert(results.count == 1)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation])
        task.cancel()
    }

    func testCoinServiceInvalidCurrencyResponse() async throws {
        let service = CoinService()
        let userDefaults = MockUserDefaults()
        let session = MockURLSession(json: .invalidCurrency)

        let expectation = expectation(description: "Service finishes with invalid currency error")

        let task = Task {
            do {
                _ = try await service.fetchCoins(fiat: "usd", urlSession: session, userDefaults: userDefaults)
            } catch {
                if error is CoingeckoErrorModel.CoingeckoError {
                    expectation.fulfill()
                } else {
                    XCTFail("Invalid error returned")
                }
            }
        }

        await fulfillment(of: [expectation], timeout: 15.0)
        task.cancel()
    }

    func testCoinServiceInvalidStatusResponse() async throws {
        let service = CoinService()
        let userDefaults = MockUserDefaults()
        let session = MockURLSession(json: .statusError)

        let expectation = expectation(description: "Service finishes with invalid currency error")

        let task = Task {
            do {
                _ = try await service.fetchCoins(fiat: "usd", urlSession: session, userDefaults: userDefaults)
            } catch {
                if let error = error as? Network.Error, case .status = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Invalid error returned")
                }
            }
        }

        await fulfillment(of: [expectation], timeout: 15.0)
        task.cancel()
    }

    func testFiatServiceCorrectResponse() async throws {
        let service = FiatService()
        let session = MockURLSession(json: .fiats)

        let expectation = expectation(description: "Coins are parsed and retured")

        let task = Task {
            let results = try await service.fetchFiats(urlSession: session)
            XCTAssert(results.count == 1)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 15.0)
        task.cancel()
    }
}
