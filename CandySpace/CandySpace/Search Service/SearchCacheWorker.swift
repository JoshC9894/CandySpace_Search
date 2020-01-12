//
//  SearchCacheWorker.swift
//  CandySpace
//
//  Created by Joshua Colley on 13/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

protocol SearchCacheWorkerProtocol {
    func saveToCache(key: String, image: UIImage)
    func retrieveFromCache(key: String) -> UIImage?
}

class SearchCacheWorker: SearchCacheWorkerProtocol {
    private let cacheMemory: Int = 200 * 1024 * 1024 // 200 MB
    private let cacheImageLimit: Int = 150
    
    static let shared: SearchCacheWorker = SearchCacheWorker()
    private var cache: NSCache<NSString, UIImage>
    
    init() {
        cache = NSCache<NSString, UIImage>()
        cache.countLimit = cacheImageLimit
        cache.totalCostLimit = cacheMemory
    }
    
    // MARK: - Protocol Methods
    func saveToCache(key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func retrieveFromCache(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
