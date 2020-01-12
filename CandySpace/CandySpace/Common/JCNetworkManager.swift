//
//  JCNetworkManager.swift
//  Networking
//
//  Created by Joshua Colley on 03/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

// Response Sealed Class
enum JCServerResponse<T> {
    case success(T)
    case failed(JCServerError)
}


struct JCServerError {
    var message: String
}

extension JCServerError {
    init(error: Error) {
        self.message = error.localizedDescription
    }
    
    init() {
        self.message = "Oops... An error occurred!"
    }
}

enum JCNetworkRequestType: String {
    case post = "POST"
    case get = "GET"
}

protocol JCNetworkManagerProtocol {
    func request(url: URL, type: JCNetworkRequestType, data: Data?, completion: @escaping (JCServerResponse<Data>) -> Void)
}
class JCNetworkManager: JCNetworkManagerProtocol {
    // Static Instance
    static var shared: JCNetworkManagerProtocol = JCNetworkManager()
    
    // Request Methods
    func request(url: URL, type: JCNetworkRequestType, data: Data?, completion: @escaping (JCServerResponse<Data>) -> Void) {
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = type.rawValue
        executeTask(request: request, completion: completion)
        
    }
    
    // Helper Methods
    fileprivate func executeTask(request: URLRequest, completion: @escaping (JCServerResponse<Data>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(JCServerResponse.failed(JCServerError(error: error)))
                return
            }
            guard let data = data else { completion(JCServerResponse.failed(JCServerError())); return }
            completion(JCServerResponse.success(data))
        }
        task.resume()
    }
}
