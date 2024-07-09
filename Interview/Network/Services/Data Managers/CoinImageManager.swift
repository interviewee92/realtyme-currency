//
//  ImageDownloader.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

final class CoinImageManager: ImageManagerProtocol {
    private let cache = NSCache<NSString, UIImage>()
    private let imageService: ImageServiceProtocol
    private var runningTasks: [String: Task<Void, Never>] = [:]
    
    required init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
    }

    func getImage(for key: String) -> UIImage? {
        return cache.object(forKey: .init(string: key.uppercased()))
    }

    func downloadAndCacheImage<T: Hashable>(item: T, key: String, urlString: String, completion: @escaping (T, UIImage?) -> Void) {
        if let image = getImage(for: key.uppercased()) {
            completion(item, image)
            return
        }

        guard let url = URL(string: urlString) else { return }
        guard runningTasks[key] == nil else { return }

        let task = Task(priority: .background) {
            do {
                let image = try await imageService.fetchImageData(url: url)
                let nsKey = NSString(string: key.uppercased())
                cache.setObject(image ?? UIImage(), forKey: nsKey)
                completion(item, image)
            } catch {
                print("Downloading image failed")
            }
        }

        runningTasks.updateValue(task, forKey: key.uppercased())
    }

    func cancelImageDownload(for key: String) {
        if let task = runningTasks[key.uppercased()] {
            task.cancel()
            runningTasks.removeValue(forKey: key.uppercased())
        }
    }
}
