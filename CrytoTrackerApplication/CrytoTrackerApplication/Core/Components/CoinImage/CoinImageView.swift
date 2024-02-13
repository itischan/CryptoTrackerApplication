//
//  CoinImageView.swift
//  CryptoTrackerApplication
//
//  Created by Vinayak on 2/13/24
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "xmark.fill")
                    .foregroundColor(Color.orange)
            }
        }
    }
}

#Preview{
    CoinImageView(coin: DeveloperPreview.instance.coin)
}

