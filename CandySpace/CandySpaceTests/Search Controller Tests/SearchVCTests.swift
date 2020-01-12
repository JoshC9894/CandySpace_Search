//
//  SearchVCTests.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import XCTest
@testable import CandySpace

// MARK: - View Controller
class SearchVCTests: XCTestCase {
    
    var sut: SearchVC?
    var routerSpy: SearchRouterSpy!

    override func setUp() {
        sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        routerSpy = SearchRouterSpy()
        sut?.router = routerSpy
    }
    
    func testDisplayError() {
        let error = JCServerError(message: "Error")
        
        sut?.displayError(error)
        
        XCTAssertTrue(routerSpy.didCallPresentAlert)
    }
    
    func testDisplayResult() {
        let hit = SearchHit(imageSize: CGSize(width: 200, height: 200), imageURL: nil)
        let result = SearchResult(total: 1, hits: [hit])
        
        sut?.displayResult(result)
        
        XCTAssertTrue(routerSpy.didCallPresentResultVC)
    }
}
