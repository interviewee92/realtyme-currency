//
//  MockUserDefaults.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var storedValue: String? = nil
    var key: String? = nil

    override func set(_ value: Any?, forKey defaultName: String) {
        storedValue = value as? String
        key = defaultName
    }

    override func string(forKey _: String) -> String? {
        return storedValue
    }
}
