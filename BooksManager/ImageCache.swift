//
//  ImageCache.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 25/03/2021.
//

import Foundation
import SwiftUI

protocol Cacheable {
    associatedtype cachedBy
    associatedtype keyType
    associatedtype valueType
    
    subscript(by key: cachedBy) -> valueType? { get set }
    init(countLimit: Int, totalSize: Int)
}

struct ImageCache: Cacheable {
    private let cache = NSCache<keyType, valueType>()
    
    subscript(by key: cachedBy) -> UIImage? {
        get { cache.object(forKey: key as keyType) }
        set {
            if let new = newValue {
                cache.setObject(new, forKey: key as keyType )
            } else {
                cache.removeObject(forKey: key as keyType)
            }
        }
    }
    
    init(countLimit: Int, totalSize: Int) {
        cache.countLimit = countLimit
        cache.totalCostLimit = totalSize * 1024 * 1024
    }
    
    typealias cachedBy = String
    typealias keyType = NSString
    typealias valueType = UIImage
}

// MARK: -- Adding ImageCache to Environment

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue = ImageCache(countLimit: 100, totalSize: 30)
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
