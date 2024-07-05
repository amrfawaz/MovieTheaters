//
//  ImageCache.swift
//
//
//  Created by AmrFawaz on 05/07/2024.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private var cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
