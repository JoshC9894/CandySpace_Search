//
//  SearchInteractor.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol {
    func searchBy(queryString: String?)
}

class SearchInteractor: SearchInteractorProtocol {
    var searchService: SearchServiceProtocol
    var presenter: SearchPresenterProtocol
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        searchService = SearchService()
    }
    
    // MARK: - Implement Protocol
    func searchBy(queryString: String?) {
        if let query = queryString, query != "" {
            searchService.fetchImageLinks(query: query) { (response) in
                switch response {
                case .success(let result): self.presenter.presentResult(result)
                case .failed(let error): self.presenter.presentError(error)
                }
            }
            return
        }
        
        let error = JCServerError(message: "Search query can't be empty")
        presenter.presentError(error)
        return
    }
}
