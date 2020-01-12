//
//  SearchPresenterTests.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import XCTest
@testable import CandySpace

class SearchPresenterTests: XCTestCase {

    var sut: SearchPresenter?
    var viewSpy: SearchVCSpy!
    var testQueue: DispatchQueue!
    
    override func setUp() {
        viewSpy = SearchVCSpy()
        testQueue = DispatchQueue(label: "testQueue")
        sut = SearchPresenter(view: viewSpy)
        sut?.queue = testQueue
    }
    
    func testPresentResult() {
        let hit = SearchHit(imageSize: CGSize(width: 200, height: 200), imageURL: nil)
        let result = SearchResult(total: 1, hits: [hit])
        
        sut?.presentResult(result)
        
        testQueue.sync { }
        
        XCTAssertTrue(viewSpy.didCallDisplayResult)
    }
    
    func testPresentError() {
        let error = JCServerError(message: "Error")
        
        sut?.presentError(error)
        
        testQueue.sync { }
        
        XCTAssertTrue(viewSpy.didCallDisplayError)
    }
}
