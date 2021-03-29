//
//  SearchView.swift
//  StockX
//
//  Created by Egor Markov on 2/21/21.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @ObservedObject var searchManager = SearchManager()
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
            VStack {
                HStack {
                    SearchBar(text: $searchText) { (changed) in
                        print("onEditingChanged - \(changed)")
                    } commit: {
                        print("onCommit")
                        searchManager.searchStoks(keyword: searchText)
                    }

                }
                
                Spacer()
                
                ScrollView {
                    ForEach(searchManager.searches) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.symbol)
                                    .font(.title)
                                    .bold()
                                Text(item.type)
                                    .font(.body)
                            }
                            Spacer()
                            Text(item.name)
                            Spacer()
                            Button(action: {
                                UserDefaultManager.shared.set(symbol: item.symbol)
                            }, label: {
                               Image(systemName: "plus.circle.fill")
                                .font(.title)
                            })
                        }
                        .foregroundColor(.black)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 2)
                    }
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 16)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
