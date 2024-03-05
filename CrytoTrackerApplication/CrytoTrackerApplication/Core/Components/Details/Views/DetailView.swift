//
//  DetailView.swift
//  CrytoTrackerApplication
//
//  Created by Vinayak Dev on 2024-03-04.
//

import SwiftUI

struct DetailView: View {
    let coin:CoinModel
    init(coin: CoinModel) {
        self.coin = coin
    }
    var body: some View {
        Text(coin.name)
            .font(.largeTitle)
        
        Text("Further details to be added upon next sprint .Thanks")
        
        
        
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
