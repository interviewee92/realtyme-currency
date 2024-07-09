//
//  DataArrayResponse.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

struct DataArrayResponse<T: Codable>: Codable {
    let data: [T]
}
