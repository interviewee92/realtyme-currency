//
//  MockURLSession.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

import Foundation
@testable import Interview

class MockURLSession: AnyURLSession {
    enum JSON: String {
        case fiats
        case coins
        case invalidCurrency
        case statusError

        var statusCode: Int {
            switch self {
            case .coins, .fiats: return 200
            default: return 400
            }
        }
    }

    private let json: JSON

    init(json: JSON) {
        self.json = json
    }

    func data(from _: URL) async throws -> (Data, URLResponse) {
        if let bundlePath = Bundle(for: type(of: self)).path(forResource: json.rawValue, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        {
            let response = HTTPURLResponse(
                url: URL(string: "http://test.pl/")!,
                statusCode: json.statusCode,
                httpVersion: nil,
                headerFields: nil
            )!

            return (jsonData, response)
        } else {
            throw NSError()
        }
    }
}
