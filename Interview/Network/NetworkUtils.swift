//
//  Network.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

// General purpose helper class

final class Network {
    static func getJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601withOptionalFractionalSeconds
        return decoder
    }

    // MARK: - Api Key

    private static let kCoingeckoDemoApiKeyUserDefaultsKey = "kCoingeckoDemoApiKeyUserDefaultsKey"

    static func setCoingeckoDemoApiKey(_ apiKey: String, userDefaults: UserDefaults = .standard) {
        userDefaults.set(apiKey, forKey: kCoingeckoDemoApiKeyUserDefaultsKey)
    }

    static func getCoingeckoDemoApiKey(userDefaults: UserDefaults = .standard) -> String? {
        return userDefaults.string(forKey: kCoingeckoDemoApiKeyUserDefaultsKey)
    }
}

extension Network {
    enum Error: LocalizedError {
        case invalidUrl
        case invalidResponse
        case status(message: String)

        var errorDescription: String? {
            switch self {
            case .invalidUrl: return "Invalid url"
            case .invalidResponse: return "Unknown response"
            case let .status(message): return "\(message)"
            }
        }
    }
}
