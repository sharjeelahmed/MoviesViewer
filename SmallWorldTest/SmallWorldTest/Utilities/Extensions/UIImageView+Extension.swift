//
//  UIImageView+Extension.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit
extension UIImageView {
    func loadImage(fromUrl urlString: String) {
        ImageCacheManager.shared.downloadImage(fromUrl: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
