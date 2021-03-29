//
//  SerchResponse.swift
//  StockX
//
//  Created by Egor Markov on 2/21/21.
//

import Foundation

struct SearchResponse: Codable {
    let bestMatches: [SearchSymbol]
}

