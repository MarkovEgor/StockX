//
//  DownloadHelper.swift
//  StockX
//
//  Created by Egor Markov on 3/26/21.
//

import Foundation

let apiKey = "FGFRCWAWV09UY1MT"

func generateRequestURL(stockSymbol: String) -> String {
    return "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(stockSymbol)&interval=5min&outputsize=full&apikey=\(apiKey)"
}
