//
//  ImageCache.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import UIKit

class ImageCache {
    typealias CacheType = NSCache<NSString, UIImage>

    static let shared = ImageCache()

    private init() {}

    private lazy var cache: CacheType = {
        let cache = CacheType()
        return cache
    }()

    func object(forkey key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }

    func set(object: UIImage, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
