//
//  ValidationView.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class ValidationView: UIView {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.fromNib()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fromNib()
        setupUI()
    }
    
    private func setupUI() {
        wrapperView.layer.cornerRadius = 4.0
        wrapperView.layer.borderColor = UIColor.red.cgColor
        wrapperView.layer.borderWidth = 1.0
        textLabel.textColor = .red
    }
}
