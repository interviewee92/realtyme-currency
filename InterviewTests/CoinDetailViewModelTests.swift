//
//  CoinDetailViewModelTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

import Combine
@testable import Interview
import XCTest

final class CoinDetailViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var viewModel: CoinDetailViewModel!

    var initialData: CoinData {
        return CoinData(
            name: "CoinName",
            symbol: "COIN",
            price: "10 USD",
            lowest24hPrice: "9 USD",
            highest24hPrice: "11 USD",
            lastUpdatedTime: Date().formatted(),
            imageUrlString: "url",
            image: nil
        )
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        viewModel = CoinDetailViewModel(coinData: initialData)
    }

    func testCoinDetailViewModelInitialDataState() async throws {
        XCTAssertEqual(viewModel.coinData.hashValue, initialData.hashValue)
    }

    func testCoinDetailViewModelIsSendingUpdateEvents() async throws {
        let expectation = XCTestExpectation(description: "Did download and set fiat data from service")

        let newData = CoinData(
            name: "CoinName",
            symbol: "COIN",
            price: "10 USD",
            lowest24hPrice: "9 USD",
            highest24hPrice: "11 USD",
            lastUpdatedTime: Date().formatted(),
            imageUrlString: "url",
            image: nil
        )

        viewModel
            .dataPublisher
            .sink { data in
                if data.hashValue == newData.hashValue {
                    expectation.fulfill()
                } else {
                    XCTFail("Data has not been updated")
                }
            }
            .store(in: &cancellables)

        viewModel.start()
        await fulfillment(of: [expectation], timeout: 15.0)
    }
}
