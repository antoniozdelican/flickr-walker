//
//  ImageCache.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

protocol ImageCacheProtocol {
    subscript(_ path: String) -> Data? { get set }
    func clear()
}

struct ImageCache: ImageCacheProtocol {
    private let cache = NSCache<NSString, NSData>()
    
    subscript(_ path: String) -> Data? {
        get {
            cache.object(forKey: path as NSString) as Data?
        }
        set {
            if let newValue = newValue as NSData? {
                cache.setObject(newValue, forKey: path as NSString)
            } else {
                cache.removeObject(forKey: path as NSString)
            }
        }
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCacheProtocol = ImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCacheProtocol {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
}
