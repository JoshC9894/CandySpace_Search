//
//  SearchVCSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
@testable import CandySpace

class SearchVCSpy: SearchViewProtocol {
    var didCallDisplayError: Bool = false
    var didCallDisplayResult: Bool = false
    
    func displayError(_ error: JCServerError) {
        didCallDisplayError = true
    }
    
    func displayResult(_ result: SearchResult) {
        didCallDisplayResult = true
    }
}
