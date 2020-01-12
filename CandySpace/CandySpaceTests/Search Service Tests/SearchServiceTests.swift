//
//  SearchServiceTests.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import XCTest
@testable import CandySpace

class SearchServiceTests: XCTestCase {

    var sut: SearchService!
    var networkManagerSpy: JCNetworkManagerSpy!
    var searchCacheSpy: SearchCacheWorkerSpy!
    
    override func setUp() {
        networkManagerSpy = JCNetworkManagerSpy()
        searchCacheSpy = SearchCacheWorkerSpy()
        sut = SearchService()
        sut.networkManager = networkManagerSpy
        sut.cacheWorker = searchCacheSpy
    }
    
    func testFetchImageLinks_Success() {
        let query = "search query"
        networkManagerSpy.fileName = "MockSearchResponse"
        let expectation = XCTestExpectation(description: "api response")
        var response: JCServerResponse<SearchResult>?
        
        sut.fetchImageLinks(query: query) { (apiResponse) in
            response = apiResponse
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        
        guard let result = response else {
            XCTFail("No result"); return
        }
        
        switch result {
        case .success(let model):
            XCTAssertEqual(model.total, 500)
            guard let hit = model.hits.first else { XCTFail("No result"); return }
            XCTAssertEqual(hit.imageSize.width, 640)
            XCTAssertEqual(hit.imageSize.height, 426)
            let url = URL(string: "https://pixabay.com/get/55e0d340485aa814f6da8c7dda79367d1436d9e550526c4870287ad49044cc5fba_640.jpg")!
            XCTAssertEqual(hit.imageURL, url)
            
        default: XCTFail("Failure Response")
        }
    }
    
    func testFetchImageLinks_Failure() {
        let query = "search query"
        let expectation = XCTestExpectation(description: "api response")
        var response: JCServerResponse<SearchResult>?
        
        sut.fetchImageLinks(query: query) { (apiResponse) in
            response = apiResponse
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        
        guard let result = response else {
            XCTFail("No result"); return
        }
        
        switch result {
        case .failed(let error): XCTAssertEqual(error.message, "No file found")
        default: XCTFail("Success Response")
        }
    }
    
    func testFetchImage_SuccessfulNetworkCall() {
        let url = URL(string: "imageURL")!
        let expectation = XCTestExpectation(description: "api response")
        var response: JCServerResponse<UIImage>?
        networkManagerSpy.image = UIImage(named: "icon")
        
        sut.fetchImage(url: url) { (apiResponse) in
            response = apiResponse
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(searchCacheSpy.didCallRetrieveFromCache)
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        XCTAssertTrue(searchCacheSpy.didCallSaveToCache)
        
        guard let result = response else {
            XCTFail("No result"); return
        }
        
        switch result {
        case .success(let image):
            XCTAssertTrue(image.isKind(of: UIImage.self))
            
        default: XCTFail("Failed Response")
        }
    }
    
    func testFetchImage_RetrievedFromCache() {
        let url = URL(string: "imageURL")!
        let expectation = XCTestExpectation(description: "cache response")
        searchCacheSpy.image = UIImage(named: "icon")
        
        sut.fetchImage(url: url) { (_) in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(searchCacheSpy.didCallRetrieveFromCache)
        XCTAssertFalse(networkManagerSpy.didCallRequest)
        XCTAssertFalse(searchCacheSpy.didCallSaveToCache)
    }
    
    func testFetchImage_Failure() {
        let url = URL(string: "imageURL")!
        let expectation = XCTestExpectation(description: "api response")
        var response: JCServerResponse<UIImage>?
        
        sut.fetchImage(url: url) { (apiResponse) in
            response = apiResponse
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        
        guard let result = response else {
            XCTFail("No result"); return
        }
        
        switch result {
        case .failed(let error): XCTAssertEqual(error.message, "No file found")
        default: XCTFail("Success Response")
        }
    }
}
