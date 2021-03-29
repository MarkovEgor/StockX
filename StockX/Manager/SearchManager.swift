//
//  SearchManager.swift
//  StockX
//
//  Created by Egor Markov on 2/21/21.
//

import Foundation

final class SearchManager: ObservableObject {
    
    @Published var searches = [SearchSymbol]()
    
    
    func searchStoks(keyword: String) {
        NetworkManager<SearchResponse>().fetch(url: URL(string: Api.synbolSearchUrl(for: keyword))!) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                DispatchQueue.main.async {
                    self.searches = response.bestMatches
                }
                
            }
        }
    }
    
}

