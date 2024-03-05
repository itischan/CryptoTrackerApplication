//
//  DetailView.swift
//  CryptoTrackerApplication
//
//  Created by Judin Joseph on 2024-03-04.
//

import SwiftUI

struct DetailView: View {
    let coin:CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        
    }
    var body: some View {
        Text(coin.name)
        Text("\(coin.currentPrice)")
    }
    
}

#Preview {
    DetailView()
}
