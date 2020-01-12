//
//  SearchResultDTO.swift
//  CandySpace
//
//  Created by Joshua Colley on 12/10/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation

struct SearchResultDTO: Codable {
    let totalHits: Int
    let hits: [SearchHitDTO]
}

struct SearchHitDTO: Codable {
    let webformatWidth: Int
    let webformatHeight: Int
    let webformatURL: String
}
