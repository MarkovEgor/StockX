//
//  LoadingView.swift
//  StockX
//
//  Created by Egor Markov on 3/28/21.
//

import SwiftUI

struct LoadingView: View {
    
    
    @State private var isLoading = false
    
    
    var body: some View {
        Circle()
            .trim(from: 0.2, to: 0.7)
            .stroke(Color.black, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.default.repeatForever(autoreverses: false))
            .onAppear() {
                self.isLoading = true
            }
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
