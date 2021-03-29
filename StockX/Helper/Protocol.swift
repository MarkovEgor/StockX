//
//  Protocol.swift
//  StockX
//
//  Created by Egor Markov on 3/28/21.
//

import Foundation

protocol QuoteManagerProtocol {
   
    var quotes: [Quote] { get set }
    
    func download(stocks: [String], copletion: @escaping (Result<[Quote], NetworkErrors>) -> Void )
}
