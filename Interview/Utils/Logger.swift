//
//  Logger.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import Foundation

class Logger {
    enum LogType: String {
        case debug = "✏️"
        case network = "🌐"
        case error = "🔴"
        case success = "✅"
    }

    static func log(_ message: String, type: LogType = .debug, file: String = #file, function: String = #function) {
        #if DEBUG
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                let filename = file.components(separatedBy: "/").last ?? ""
                print("\n" + type.rawValue + "\t\(filename) - \(function)\n" + type.rawValue + "\t\(message)")
            }
        #endif
    }
}
