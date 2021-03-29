//
//  Api.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import Foundation

struct Api {
    
    static var BaseURl = "https://www.alphavantage.co/query?"
    static let key = "FGFRCWAWV09UY1MT"
    
    enum SymbolFunc: String {
        case symbolSearch = "SYMBOL_SEARCH"
        case symbolQuote = "GLOBAL_QUOTE"
    }
    
    static func synbolSearchUrl(for searchKey: String) -> String {
        print(urlFetch(symbol: .symbolSearch, searchKey: searchKey))
        return urlFetch(symbol: .symbolSearch, searchKey: searchKey)
    }
    
    static func symbolQuoteUrl(for searchKey: String) -> String {
        return urlFetch(symbol: .symbolQuote, searchKey: searchKey)
    }
    
    private static func urlFetch(symbol: SymbolFunc, searchKey: String) -> String {
        switch symbol {
        case .symbolSearch:
            return "\(Api.BaseURl)function=\(symbol.rawValue)&apikey=\(Api.key)&keywords=\(searchKey)"
        case .symbolQuote:
            return "\(Api.BaseURl)function=\(symbol.rawValue)&apikey=\(Api.key)&symbol=\(searchKey)"
        }
    }
}
