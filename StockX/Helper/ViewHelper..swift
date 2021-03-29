//
//  ViewHelper..swift
//  StockX
//
//  Created by Egor Markov on 3/24/21.
//

import SwiftUI

func getPercentageChange(stockData: [DataEntry]) -> Double {
    if let lastEntryClose = stockData.last?.close, let firstEntryClose = stockData.first?.close {
        return ((lastEntryClose - firstEntryClose) / lastEntryClose) * 100
    } else {
        return 0
    }
}



func bullishBearishGradient(lastClose: Double, firstClose: Double) -> Gradient {
    if lastClose < firstClose {
        return Gradient(colors: [Color.red, Color.clear])
    } else {
        return Gradient(colors: [Color.green, Color.clear])
    }
}
