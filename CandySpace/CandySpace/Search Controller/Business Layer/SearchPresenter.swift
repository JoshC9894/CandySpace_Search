//
//  SearchPresenter.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

protocol SearchPresenterProtocol {
    func presentResult(_ result: SearchResult)
    func presentError(_ error: JCServerError)
}

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var queue: DispatchQueue = .main
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    // MARK: - Protocol Methods
    func presentResult(_ result: SearchResult) {
        queue.async {
            self.view?.displayResult(result)
        }
    }
    
    func presentError(_ error: JCServerError) {
        queue.async {
            self.view?.displayError(error)
        }
    }
}
