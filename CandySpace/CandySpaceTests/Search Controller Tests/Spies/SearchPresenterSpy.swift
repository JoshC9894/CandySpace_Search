//
//  SearchPresenterSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
@testable import CandySpace

class SearchPresenterSpy: SearchPresenterProtocol {
    var didCallPresentResult: Bool = false
    var didCallPresentError: Bool = false
    
    func presentResult(_ result: SearchResult) {
        didCallPresentResult = true
    }
    
    func presentError(_ error: JCServerError) {
        didCallPresentError = true
    }
}
