//
//  Fiat.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

struct Fiat: Codable, FiatModelType {
    let id: String
    let name: String
    let minSize: String?
}
