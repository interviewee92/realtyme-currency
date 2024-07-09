//
//  ImageService.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

class ImageService: ImageServiceProtocol {
    func fetchImageData(url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return UIImage(data: data)
    }
}
