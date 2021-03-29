//
//  UserDefaultManager.swift
//  StockX
//
//  Created by Egor Markov on 2/21/21.
//

import Foundation

final class UserDefaultManager {
    
    private static let symbolKey = "SYMBOL_KEY"
    
    var saveSymbols = ["YNDX","AAPL","GOOGL"]
    
    static let shared = UserDefaultManager()
    
    private init() {
        get()
    }
    
    func get() {
        if let saved = UserDefaults.standard.array(forKey: Self.symbolKey) as? [String] {
            saveSymbols = saved
        }
    }
    
    func set(symbol: String) {
        saveSymbols.append(symbol)
        UserDefaults.standard.set(self.saveSymbols, forKey: Self.symbolKey)
    }
}
