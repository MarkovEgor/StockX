//
//  JSONModel.swift
//  StockX
//
//  Created by Egor Markov on 3/26/21.
//

import SwiftUI

struct TimeSeriesJSON: Codable {
    
    let timeSeries: [String: TimeSeries]
    
    private enum CodingKeys : String, CodingKey {
        case timeSeries = "Time Series (5min)"
    }
    
    struct TimeSeries: Codable {
        let open, close, high, low: String
        
        private enum CodingKeys : String, CodingKey {
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
        }
    }
}
