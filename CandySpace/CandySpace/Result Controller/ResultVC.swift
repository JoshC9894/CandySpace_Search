//
//  ResultVC.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var result: SearchResult!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Results"
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }
}

extension ResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        switch cell {
        case let cell as ImageCell:
            let hit = result.hits[indexPath.row]
            cell.bindData(hit)
        default: break
        }
        return cell
    }
}

extension ResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  32.0
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}
