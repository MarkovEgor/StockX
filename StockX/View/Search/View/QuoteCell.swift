//
//  QuoteCell.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import SwiftUI

struct QuoteCell: View {
    
    var quote: Quote
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                     Text(quote.symbol)
                         .font(.custom("Avenir", size: 20))
                         .fontWeight(.medium)

            }
       
             Spacer()
             VStack(alignment: .trailing) {
                Text(quote.change.dropLast(2) + "%")
                     .font(.custom("Avenir", size: 14))
                     .fontWeight(.medium)
                     .foregroundColor(.green)
                Text("$" + quote.price.dropLast(2))
                     .font(.custom("Avenir", size: 26))
             }
        }
    }
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCell(quote: Quote(symbol: "AAPL", open: "136.90", high: "123.56", low: "134.87", price: "145.89", volume: "6578741", atestTradingDay: "2021-02-19", previousClose: "120.7300", change: "-0.34", changePercent: "+0.19%"))
    }
}
