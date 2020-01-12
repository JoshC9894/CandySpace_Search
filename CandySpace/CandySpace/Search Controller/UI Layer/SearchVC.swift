//
//  SearchVC.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    func displayError(_ error: JCServerError)
    func displayResult( _ result: SearchResult)
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var validationView: ValidationView!
    
    var interactor: SearchInteractorProtocol!
    var presenter: SearchPresenterProtocol!
    var router: SearchControllerRouterProtocol!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = SearchPresenter(view: self)
        interactor = SearchInteractor(presenter: presenter)
        router = SearchControllerRouter(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2.0
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        searchField.addTarget(self, action: #selector(validateSearchField(_:)), for: .editingChanged)
        searchField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        validationView.isHidden = true
        searchButton.isEnabled = false
        searchButton.backgroundColor = UIColor.black.withAlphaComponent(0.65)
    }
    
    // MARK: - Actions
    @objc private func search() {
        dismissKeyboard()
        let queryString = self.searchField.text
        self.interactor.searchBy(queryString: queryString)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func validateSearchField(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            validationView.isHidden = false
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.black.withAlphaComponent(0.65)
            return
        }
        validationView.isHidden = true
        searchButton.isEnabled = true
        searchButton.backgroundColor = UIColor.black
    }
}

// MARK: - Implement View Protocol
extension SearchVC: SearchViewProtocol {
    func displayError(_ error: JCServerError) {
        router.presentAlert(with: error, retry: search)
    }
    
    func displayResult(_ result: SearchResult) {
        router.presentResultVC(result: result)
    }
}

// MARK: - Textfield Delegate
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }
}
