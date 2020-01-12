//
//  ImageCell.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoImageView: UIImageView!
    
    var searchService: SearchServiceProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchService = SearchService()
        infoImageView.tintColor = AppTheme.colour.lightGrey
        infoImageView.image = UIImage(named: "placeholder-image")
        imageView.isHidden = true
        imageView.layer.cornerRadius = 5.0
        wrapperView.layer.cornerRadius = 5.0
        wrapperView.layer.shadowColor = AppTheme.colour.darkGrey.cgColor
        wrapperView.layer.shadowRadius = 2.0
        wrapperView.layer.shadowOpacity = 0.45
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
    }
    
    func bindData(_ model: SearchHit) {
        if let url = model.imageURL {
            searchService.fetchImage(url: url, completion: decodeImageResponse(_:))
        }
        infoImageView.startLoading(size: .large)
        imageView.isHidden = false
    }
    
    private func decodeImageResponse(_ response: JCServerResponse<UIImage>) {
        switch response {
        case .success(let image):
            DispatchQueue.main.async {
                self.imageView.image = image
                self.infoImageView.isHidden = true
                self.infoImageView.stopLoading()
            }
        case .failed:
            DispatchQueue.main.async {
                self.infoImageView.image = UIImage(named: "error")
                self.infoImageView.stopLoading()
            }
        }
        
    }
}
