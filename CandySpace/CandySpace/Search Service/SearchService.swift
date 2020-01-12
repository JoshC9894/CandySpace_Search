//
//  SearchService.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
import UIKit

protocol SearchServiceProtocol {
    func fetchImageLinks(query: String, completion: @escaping ((JCServerResponse<SearchResult>) -> Void))
    func fetchImage(url: URL, completion: @escaping ((JCServerResponse<UIImage>) -> Void))
}

class SearchService: SearchServiceProtocol {

    var networkManager: JCNetworkManagerProtocol
    var cacheWorker: SearchCacheWorkerProtocol
    
    init() {
        networkManager = JCNetworkManager.shared
        cacheWorker = SearchCacheWorker.shared
    }
    
    // MARK: - Protocol Methods
    func fetchImageLinks(query: String, completion: @escaping ((JCServerResponse<SearchResult>) -> Void)) {
        let url = searchURL(query: query)
        debugPrint("@DEBUG: \(url)")
        networkManager.request(url: url, type: .get, data: nil) { (response) in
            switch response {
            case .success(let data):
                guard let dto = try? JSONDecoder().decode(SearchResultDTO.self, from: data) else {
                    let error = JCServerError(message: "Failed to decode response.")
                    completion(JCServerResponse.failed(error))
                    return
                }
                let result = SearchResult(dto: dto)
                completion(JCServerResponse.success(result))
                
            case.failed(let error):
                completion(JCServerResponse.failed(error))
            }
        }
    }
    
    func fetchImage(url: URL, completion: @escaping ((JCServerResponse<UIImage>) -> Void)) {
        if let image = cacheWorker.retrieveFromCache(key: url.absoluteString) {
            completion(JCServerResponse.success(image)); return
        }
        
        networkManager.request(url: url, type: .get, data: nil) { (response) in
            switch response {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    let error = JCServerError(message: "Failed to decode response.")
                    completion(JCServerResponse.failed(error))
                    return
                }
                self.cacheWorker.saveToCache(key: url.absoluteString, image: image)
                completion(JCServerResponse.success(image))
                
            case.failed(let error):
                completion(JCServerResponse.failed(error))
            }
        }
    }
    
    // MARK: - Private Methods
    private func searchURL(query: String) -> URL {
        let endpoint: String = Endpoint.api
        let key: String = "key=\(getAPIKey())"
        let queryString = "q=\(query.replacingOccurrences(of: " ", with: "+").lowercased())"
        let imgType: String = "image_type=photo"
        
        let urlString = "\(endpoint)?\(key)&\(queryString)&\(imgType)"
        return URL(string: urlString)!
    }
    
    private func getAPIKey() -> String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict["apiKey"] as? String ?? ""
            }
        }
        return ""
    }
}
