//
//  JCNetworkManagerSpy.swift
//  CandySpaceTests
//
//  Created by Joshua Colley on 14/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit
@testable import CandySpace

class JCNetworkManagerSpy: JCNetworkManagerProtocol {
    var didCallRequest: Bool = false
    var fileName: String?
    var image: UIImage?
    
    func request(url: URL, type: JCNetworkRequestType, data: Data?, completion: @escaping (JCServerResponse<Data>) -> Void) {
        didCallRequest = true
        
        if let data = loadFromFile(filename: fileName) {
            completion(JCServerResponse.success(data))
        } else if let data = image?.pngData() {
            completion(JCServerResponse.success(data))
        } else {
            completion(JCServerResponse.failed(JCServerError(message: "No file found")))
        }
    }
    
    private func loadFromFile(filename: String?) -> Data? {
        guard let fileName = filename else { return nil }
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: fileName, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath ?? ""))
        return data
    }
}
