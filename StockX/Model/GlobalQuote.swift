//
//  GlobalQuote.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import Foundation

struct GlobalQuoteResponse: Codable {
    
    var quote: Quote
    
    private enum CodingKeys: String, CodingKey {
        case quote = "Global Quote"
    }
}

struct Quote: Codable, Identifiable {
    
    var id: UUID {return UUID()}
    var symbol: String
    var open: String
    var high: String
    var low: String
    var price: String
    var volume: String
    var atestTradingDay: String
    var previousClose: String
    var change: String
    var changePercent: String
    
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case atestTradingDay = "07. latest trading day"
        case previousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}
