//
//  ContentView.swift
//  StockX
//
//  Created by Egor Markov on 3/24/21.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var downloadManager: DownloadManager
    @State var timeFrameChoice = 0
    let stockSymbol: String
    let price: String
    
    
    var body: some View {
        
        VStack {
            
            
            if downloadManager.dataFetched {
                
                HStack {
                    Text(stockSymbol)
                        .font(.custom("Avenir", size: 40))
                        .bold()
                        .foregroundColor(.black)
                        .padding(20)
                        
                }
                
                Header(stockData:swichHeader())
                ChartView(dataSet: timeFrameChoice == 0 ? downloadManager.dailyEntries : downloadManager.weeklyEntries)
                    .frame(height: 300)
                
                Spacer()
                
                TimeFrameBar(timeFrameChoice: $timeFrameChoice)
                
                Spacer()
                TransactionButtons(price: price)
                Spacer()
                
            }else{
                
                Spacer()
                LoadingView()
                Spacer()
            }
            
           
        }
        .navigationTitle(stockSymbol)
    }
    
    func swichHeader() -> [DataEntry] {
        switch timeFrameChoice {
        case 0:
          return  downloadManager.dailyEntries
        case 1:
          return  downloadManager.weeklyEntries
        case 2:
          return  downloadManager.monthsEntries
        case 3:
          return  downloadManager.yearsEntries
        default:
            break
       }
     return []
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(downloadManager: DownloadManager(stockSymbol: "AAPL"), stockSymbol: "AAPL", price: "0.98")
    }
}

struct TimeFrameBar: View {
    
    @Binding var timeFrameChoice: Int
    
    var body: some View {
        
        HStack(spacing: 30) {
            
            Spacer()
            
            Button(action: {
                self.timeFrameChoice = 0
            }, label: {
                Text("Day")
                    .font(.custom("Avenir", size: 14))
                    .fontWeight(timeFrameChoice == 0 ? .medium : .none)
                    .foregroundColor(timeFrameChoice == 0 ? .white : .black)
            })
            .frame(width: 60, height: 35)
            .background(timeFrameChoice == 0 ? Color.black : Color.gray.opacity(0.4))
            .cornerRadius(10)
            
            Button(action: {
                self.timeFrameChoice = 1
            }, label: {
                Text("Week")
                    .font(.custom("Avenir", size: 14))
                    .fontWeight(timeFrameChoice == 1 ? .medium : .none)
                    .foregroundColor(timeFrameChoice == 1 ? .white : .black)
            })
            .frame(width: 60, height: 35)
            .background(timeFrameChoice == 1 ? Color.black : Color.gray.opacity(0.4))
            .cornerRadius(10)
            
            Button(action: {
                self.timeFrameChoice = 2
            }, label: {
                Text("Month")
                    .font(.custom("Avenir", size: 14))
                    .fontWeight(timeFrameChoice == 2 ? .medium : .none)
                    .foregroundColor(timeFrameChoice == 2 ? .white : .black)
            })
            .frame(width: 60, height: 35)
            .background(timeFrameChoice == 2 ? Color.black : Color.gray.opacity(0.4))
            .cornerRadius(10)
           
            Button(action: {
                self.timeFrameChoice = 3
            }, label: {
                Text("Yers")
                    .font(.custom("Avenir", size: 14))
                    .fontWeight(timeFrameChoice == 3 ? .medium : .none)
                    .foregroundColor(timeFrameChoice == 3 ? .white : .black)
            })
            .frame(width: 60, height: 35)
            .background(timeFrameChoice == 3 ? Color.black : Color.gray.opacity(0.4))
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}



struct Header: View {
    
    let stockData: [DataEntry]
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("$" + String(format: "%.2f", stockData.last?.close ?? 0))
                .font(.custom("Avenir", size: 45))
            Text(String(format: "%.2f", getPercentageChange(stockData: stockData)) + "%")
                .font(.custom("Avenir", size: 18))
                .fontWeight(.medium)
                .foregroundColor(.green)
        }
        .padding()
        .padding(.top, 30)
    }
}

struct TransactionButtons: View {
    
    let price: String
    
    var body: some View {
        HStack {
            Text("Buy for \(price)")
                .font(.custom("Avenir", size: 16))
                .foregroundColor(.white)
                .padding(20)
                
        }
        .frame(width: 180, height: 40)
        .background(Color.black)
        .cornerRadius(16)
    }
}
