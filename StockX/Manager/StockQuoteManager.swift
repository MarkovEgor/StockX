//
//  StockQuoteManager.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import Foundation

final class StockQuoteManager: QuoteManagerProtocol, ObservableObject {
    
    @Published var quotes: [Quote]  = []
    
    func download(stocks: [String], copletion: @escaping (Result<[Quote], NetworkErrors>) -> Void) {
        var internalQuotes = [Quote]()
        let downloadQuote = DispatchQueue(label: "com.devtechie.downloadQuote")
        let downloadGroup = DispatchGroup()
        
        stocks.forEach { (stock) in
            downloadGroup.enter()
            let url = URL(string: Api.symbolQuoteUrl(for: stock))!
            NetworkManager<GlobalQuoteResponse>().fetch(url: url) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    downloadQuote.async {
                        downloadGroup.leave()
                    }
                case .success(let response):
                    downloadQuote.async {
                        internalQuotes.append(response.quote)
                        downloadGroup.leave()
                    }
                }
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.global()) {
            copletion(.success(internalQuotes))
            DispatchQueue.main.async {
                self.quotes.append(contentsOf: internalQuotes)
            }
        }
    }
    
    
}
