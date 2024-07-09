//
//  CoinsViewTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 07/07/2024.
//

@testable import Interview
import XCTest

final class ViewTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // MARK: - CoinsView

    func testCoinsViewSubviewsAreSetup() throws {
        let view = CoinsView()
        XCTAssertNotNil(view.tableView.superview)
    }

    func testCoinsViewTableHiddenOnError() throws {
        let view = CoinsView()
        view.setError(message: "error")
        XCTAssert(view.tableView.isHidden)
    }

    func testCoinsViewInitialState() throws {
        let view = CoinsView()
        XCTAssert(view.tableView.isHidden == false)
    }

    // MARK: - CoinDetailView

    func testCoinDetailViewSubviewsAreSetUpAndRecevingData() throws {
        let view = CoinDetailView()

        view.image = UIImage()
        XCTAssert(view.image != nil)

        view.symbol = "value1"
        XCTAssertEqual(view.symbol, "value1")

        view.name = "value2"
        XCTAssertEqual(view.name, "value2")

        view.lastPrice = "value3"
        XCTAssertEqual(view.lastPrice, "value3")

        view.hightestPrice = "value3"
        XCTAssertEqual(view.hightestPrice, "value3")

        view.lowestPrice = "value4"
        XCTAssertEqual(view.lowestPrice, "value4")

        view.updatedTime = "value5"
        XCTAssertEqual(view.updatedTime, "value5")
    }

    func testCoinDetailViewSubviewsInitialState() throws {
        let view = CoinDetailView()

        XCTAssert(view.image != nil)
        XCTAssertEqual(view.symbol, "-")
        XCTAssertEqual(view.name, "-")
        XCTAssertEqual(view.lastPrice, "-")
        XCTAssertEqual(view.hightestPrice, "-")
        XCTAssertEqual(view.lowestPrice, "-")
        XCTAssertEqual(view.updatedTime, "-")
    }
}
