//
//  SearchServiceSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit
@testable import CandySpace

class SearchServiceSpy: SearchServiceProtocol {
    var didCallFetchImageLinks: Bool = false
    var didCallFetchImage: Bool = false
    
    var searchResult: SearchResult?
    var image: UIImage?
    
    func fetchImageLinks(query: String, completion: @escaping ((JCServerResponse<SearchResult>) -> Void)) {
        didCallFetchImageLinks = true
        guard let result = self.searchResult else {
            completion(JCServerResponse.failed(JCServerError(message: "No result")))
            return
        }
        completion(JCServerResponse.success(result))
    }
    
    func fetchImage(url: URL, completion: @escaping ((JCServerResponse<UIImage>) -> Void)) {
        didCallFetchImage = true
        guard let image = self.image else {
            completion(JCServerResponse.failed(JCServerError(message: "No image")))
            return
        }
        completion(JCServerResponse.success(image))
    }
}
