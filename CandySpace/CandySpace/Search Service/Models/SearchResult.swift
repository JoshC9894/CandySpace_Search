//
//  SearchResult.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
import UIKit

struct SearchResult {
    let total: Int
    let hits: [SearchHit]
}

extension SearchResult {
    init(dto: SearchResultDTO) {
        total = dto.totalHits
        hits = dto.hits.map({ SearchHit(dto: $0) })
    }
}

struct SearchHit {
    let imageSize: CGSize
    let imageURL: URL?
}

extension SearchHit {
    init(dto: SearchHitDTO) {
        imageSize = CGSize(width: dto.webformatWidth, height: dto.webformatHeight)
        imageURL = URL(string: dto.webformatURL)
    }
}
