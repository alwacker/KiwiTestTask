//
//  ImageCacheAdapter.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import Combine
import UIKit

class CacheImageAdapter: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSString, UIImage>()
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func load() {
        let urlString = url.absoluteString
        if let cachedImage = ImageCache.shared.object(forkey: url.absoluteString as NSString) {
            image = cachedImage
        } else {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .retry(3)
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.image = $0
                    ImageCache.shared.set(object: $0!, forKey: urlString as NSString)
                }
        }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
