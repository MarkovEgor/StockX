//
//  SearchBar.swift
//  StockX
//
//  Created by Egor Markov on 3/28/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = { }
    
    private var searchText: Binding<String> {

        return Binding<String>(
            get: {
                self.text.capitalized

            }, set: {
                self.text = $0
            }
        )
    }

    var body: some View {
        HStack {

            TextField("Search ...", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }


            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 5)
                .transition(.move(edge: .trailing))
                .animation(.easeInOut)
            }
        }
      
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
