//
//  SearchRouterSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
@testable import CandySpace

class SearchRouterSpy: SearchControllerRouterProtocol {
    var didCallPresentAlert: Bool = false
    var didCallPresentResultVC: Bool = false
    
    func presentAlert(with error: JCServerError, retry: (() -> Void)?) {
        didCallPresentAlert = true
    }
    
    func presentResultVC(result: SearchResult) {
        didCallPresentResultVC = true
    }
}
