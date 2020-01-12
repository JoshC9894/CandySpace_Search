//
//  SearchControllerRouter.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

protocol SearchControllerRouterProtocol {
    func presentAlert(with error: JCServerError, retry: (() -> Void)?)
    func presentResultVC(result: SearchResult)
}

class SearchControllerRouter: SearchControllerRouterProtocol {
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    // MARK: - Protocol Methods
    func presentAlert(with error: JCServerError, retry: (() -> Void)?) {
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let retryMethod = retry {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                retryMethod()
            }))
        }
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func presentResultVC(result: SearchResult) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultVC") as? ResultVC {
            vc.result = result
//            controller?.present(vc, animated: true, completion: nil)
            controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
