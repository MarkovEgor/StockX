//
//  HeeaderView.swift
//  StockX
//
//  Created by Egor Markov on 2/20/21.
//

import SwiftUI

struct HeaderView: View {
    
    private let dateformater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd"
        return formater
    }()
    
    @Binding var stocks: [String]
    @State private var showSearch = false
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: -5) {
                Text("StockX")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                Text("\(Date(), formatter: dateformater)")
                    .foregroundColor(.gray)
                    .font(.body)
                    .bold()
            }
            
            Spacer()
            
            Button(action: {
                showSearch.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .font(.title)
             
            }).sheet(isPresented: $showSearch, onDismiss: {
                self.stocks = UserDefaultManager.shared.saveSymbols
            },content: {
                SearchView()
            })
            
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(stocks: .constant(["AAPL","GOOG"]))
    }
}
