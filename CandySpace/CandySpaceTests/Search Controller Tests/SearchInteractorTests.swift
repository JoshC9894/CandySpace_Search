//
//  SearchInteractorTests.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import XCTest
@testable import CandySpace

class SearchInteractorTests: XCTestCase {
    
    var sut: SearchInteractor?
    var presenterSpy: SearchPresenterSpy!
    var searchServiceSpy: SearchServiceSpy!

    override func setUp() {
        presenterSpy = SearchPresenterSpy()
        searchServiceSpy = SearchServiceSpy()
        sut = SearchInteractor(presenter: presenterSpy)
        sut?.searchService = searchServiceSpy
    }
    
    func testSearchByQuery_ValidQuery() {
        let query = "testQuery"
        let hit = SearchHit(imageSize: CGSize(width: 200, height: 200), imageURL: nil)
        let result = SearchResult(total: 1, hits: [hit])
        searchServiceSpy.searchResult = result
        
        sut?.searchBy(queryString: query)
        
        XCTAssertTrue(searchServiceSpy.didCallFetchImageLinks)
        XCTAssertTrue(presenterSpy.didCallPresentResult)
    }
    
    func testSearchByQuery_InvalidQuery() {
        sut?.searchBy(queryString: nil)
        
        XCTAssertFalse(searchServiceSpy.didCallFetchImageLinks)
        XCTAssertTrue(presenterSpy.didCallPresentError)
    }
    
    func testSearchByQuery_ValidQuery_NetworkError() {
        let query = "testQuery"
        
        sut?.searchBy(queryString: query)
        
        XCTAssertTrue(searchServiceSpy.didCallFetchImageLinks)
        XCTAssertTrue(presenterSpy.didCallPresentError)
    }
}
