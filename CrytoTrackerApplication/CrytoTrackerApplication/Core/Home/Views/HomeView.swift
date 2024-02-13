//
//  HomeView.swift
//  CrytoTrackerApplication
//
//  Created by chandru Kumaran on 2024-02-11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm : HomeViewModel
    @State private var showPortfolio = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                HStack{
                    CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                    Spacer()
                    Text(showPortfolio ? "Current Portfolio" : "Live Prices")
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.bouncy){
                                showPortfolio.toggle()
                            }
                        }
                }
                Spacer(minLength: 0)
                HStack{
                    Text("Coin")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(showPortfolio ? "Holdings" : "")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text("Price")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                        .padding(.leading,5)
                   
                    
                    
                }
          
                List{
                    ForEach(vm.allCoins){coin in
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                    }
                    ForEach(vm.portfolioCoins){coin in
                        CoinRowView(coin: coin, showHoldingsColumn: true)
                        
                    }

                }.listStyle(PlainListStyle())
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

