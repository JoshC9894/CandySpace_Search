//
//  SearchCacheWorkerSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit
@testable import CandySpace

class SearchCacheWorkerSpy: SearchCacheWorkerProtocol {
    var didCallSaveToCache: Bool = false
    var didCallRetrieveFromCache: Bool = false
    var image: UIImage?
    
    func saveToCache(key: String, image: UIImage) {
        didCallSaveToCache = true
    }
    
    func retrieveFromCache(key: String) -> UIImage? {
        didCallRetrieveFromCache = true
        return image
    }
}
