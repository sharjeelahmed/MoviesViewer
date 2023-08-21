//
//  ImageCacheManagerProtocol.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit

protocol ImageCacheManagerProtocol {
    func downloadImage(fromUrl urlString: String, completion: @escaping ((UIImage?)-> Void))
}
