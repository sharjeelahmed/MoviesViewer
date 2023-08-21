//
//  ImageCacheManager.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit

class ImageCacheManager: ImageCacheManagerProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
        
   static let shared = ImageCacheManager()

    func downloadImageByAsync(fromUrl urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw ImageDownloadError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard let image = UIImage(data: data) else {
            throw ImageDownloadError.invalidImageData
        }
        return image
    }
    
    
    
    func downloadImage(fromUrl urlString: String, completion: @escaping ((UIImage?)-> Void)) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}

enum ImageDownloadError: Error {
    case invalidUrl
    case invalidImageData
    case networkError
}
