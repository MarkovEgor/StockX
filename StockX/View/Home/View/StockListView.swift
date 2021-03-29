//
//  StockListView.swift
//  StockX
//
//  Created by Egor Markov on 3/24/21.
//

import SwiftUI

struct StockListView: View {
    
    @State private var stocks = UserDefaultManager.shared.saveSymbols
    @ObservedObject var stockManager = StockQuoteManager()
    @State private var searchText = ""
    @State private var oldStocks = [String]()
    @State private var showDetail = false
    @State private var loding = true
    @State private var selectedQuote: Quote?

    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            
            Color.white
            
            VStack {
                
                HeaderView(stocks: $stocks)
                    .padding(.top, 80)
                    .frame(height: 100)
       
                VStack(spacing: 20) {
              
                    SearchBar(text: $searchText)
                        .padding(.top, 40)
                    
                    if loding {
                   
                        Spacer()
                        LoadingView()
                        Spacer()
                        
                    } else {
                        
                        List {
                            
                            ForEach(getQuote()) { quote in
                                QuoteCell(quote: quote)
                                    .onTapGesture {
                                        self.showDetail = true
                                        self.selectedQuote = quote
                                    }
                            }
                            
                        }
                        .sheet(isPresented: self.$showDetail) {
                               if let selectedQuote = self.selectedQuote {
                                DetailView(downloadManager: DownloadManager(stockSymbol: selectedQuote.symbol), stockSymbol: selectedQuote.symbol, price: selectedQuote.price)
                               }
                           }
                        
                    }
                    
             
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    fetchData(for: stocks)
                    oldStocks = stocks
                    }
                }.onChange(of: stocks, perform: { value in
                    fetchData(for: stocks.difference(from: oldStocks))
                    oldStocks = stocks
                })
                
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, UIScreen.main.bounds.height * 0.2)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
    private func getQuote() -> [Quote] {
        return searchText.isEmpty ? stockManager.quotes : stockManager.quotes.filter{$0.symbol.lowercased().contains(searchText.lowercased())}
    }
    
    private func fetchData(for symbol: [String]) {
        loding = false
        stockManager.download(stocks: symbol) { _ in
            loding = false
            print(false)
        }

    }
}


struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView()
    }
}

//struct StockListRow: View {
//    
//    @ObservedObject var downloadManager: DownloadManager
//    let stockSymbol: String
//    let stockName: String
//    
//    var body: some View {
//        HStack {
//            NavigationLink(destination: DetailView(downloadManager: downloadManager, stockSymbol: stockSymbol)) {
//                if downloadManager.dataFetched {
//                    VStack(alignment: .leading) {
//                        Text(stockSymbol)
//                            .font(.custom("Avenir", size: 20))
//                            .fontWeight(.medium)
//                        Text(stockName)
//                            .font(.custom("Avenir", size: 16))
//                    }
//                    Spacer()
//                    VStack(alignment: .trailing) {
//                        Text(String(format: "%.2f", getPercentageChange(stockData: downloadManager.dailyEntries)) + "%")
//                            .font(.custom("Avenir", size: 14))
//                            .fontWeight(.medium)
//                            .foregroundColor(.green)
//                        Text("$" + String(format: "%.2f",  downloadManager.dailyEntries.last?.close ?? 0))
//                            .font(.custom("Avenir", size: 26))
//                    }
//                }
//                
//            }//dataFetched
//        }
//    }
//}

