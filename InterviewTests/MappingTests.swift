//
//  MappingTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

@testable import Interview
import XCTest

final class MappingTests: XCTestCase {
    func testCoinModelMapping() throws {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withFullTime, .withFractionalSeconds]

        if let date = formatter.date(from: "2024-07-08T22:18:38.841Z"),
           let bundlePath = Bundle(for: type(of: self)).path(forResource: "coins", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        {
            let stub = Coin(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "btc",
                currentPrice: 208_342,
                high24H: 212_592,
                low24H: 199_520,
                image: "image",
                lastUpdated: date
            )

            let decoder = Network.getJSONDecoder()
            let result = try? decoder.decode([Coin].self, from: jsonData)

            XCTAssertEqual(result?.first?.id, stub.id)
            XCTAssertEqual(result?.first?.name, stub.name)
            XCTAssertEqual(result?.first?.symbol, stub.symbol)
            XCTAssertEqual(result?.first?.currentPrice, stub.currentPrice)
            XCTAssertEqual(result?.first?.high24H, stub.high24H)
            XCTAssertEqual(result?.first?.low24H, stub.low24H)
            XCTAssertEqual(result?.first?.image, stub.image)
            XCTAssertEqual(result?.first?.lastUpdated, stub.lastUpdated)
        } else {
            XCTFail()
        }
    }

    func testFiatModelMapping() throws {
        if let bundlePath = Bundle(for: type(of: self)).path(forResource: "fiats", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        {
            let stub = Fiat(
                id: "AED",
                name: "United Arab Emirates Dirham",
                minSize: "0.01"
            )

            let decoder = Network.getJSONDecoder()
            let result = try? decoder.decode(DataArrayResponse<Fiat>.self, from: jsonData)

            XCTAssertEqual(result?.data.first?.id, stub.id)
            XCTAssertEqual(result?.data.first?.name, stub.name)
            XCTAssertEqual(result?.data.first?.minSize, stub.minSize)
        } else {
            XCTFail()
        }
    }

    func testCoingeckoErrorModelMapping() throws {
        if let bundlePath = Bundle(for: type(of: self)).path(forResource: "invalidCurrency", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        {
            let decoder = Network.getJSONDecoder()
            let stub = CoingeckoErrorModel(error: .invalidCurrency)
            let result = try? decoder.decode(CoingeckoErrorModel.self, from: jsonData)

            XCTAssertEqual(result?.error, stub.error)

        } else {
            XCTFail()
        }
    }

    func testCoingeckoStatusErrorModelMapping() throws {
        if let bundlePath = Bundle(for: type(of: self)).path(forResource: "statusError", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        {
            let decoder = Network.getJSONDecoder()
            let stub = CoingeckoStatusModel(status: .init(errorMessage: "status message"))
            let result = try? decoder.decode(CoingeckoStatusModel.self, from: jsonData)

            XCTAssertEqual(result?.status.errorMessage, stub.status.errorMessage)

        } else {
            XCTFail()
        }
    }
}
