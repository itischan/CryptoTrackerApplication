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
    @State private var showPortfolioView = false
    @State private var showSettingsView = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            VStack{
                HStack{
                    CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                        .onTapGesture {
                            if showPortfolio {
                                showPortfolioView.toggle()
                            }
                            else{
                                showSettingsView.toggle()
                            }
                        }
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
                SearchBarView(searchText: $vm.searchText)
                Spacer(minLength: 0)
                columnTitles

          
                List{
                    if !showPortfolio{
                        ForEach(vm.allCoins){coin in
                            NavigationLink {
                                DetailView(coin: coin)
                            } label: {
                                CoinRowView(coin: coin, showHoldingsColumn: false)
                            }
                        }

                        
                    }
                    if showPortfolio{
                    
                        ForEach(vm.portfolioCoins){coin in
                            NavigationLink {
                                DetailView(coin: coin)
                            } label: {
                                CoinRowView(coin: coin, showHoldingsColumn: true)
                            }
                            
                        }
                        
                    }

                }.listStyle(PlainListStyle())
            }
        }.sheet(isPresented: $showSettingsView, content: {
            SettingsView()
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension HomeView{
    private var columnTitles: some View {
            HStack {
                HStack(spacing: 4) {
                    Text("Coin")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                    }
                }
                
                Spacer()
                if showPortfolio {
                    HStack(spacing: 4) {
                        Text("Holdings")
                        Image(systemName: "chevron.down")
                            .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                            .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                    }
                    .onTapGesture {
                        withAnimation(.default) {
                            vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                        }
                    }
                }
                HStack(spacing: 4) {
                    Text("Price")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                    }
                }
                
                Button(action: {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                }, label: {
                    Image(systemName: "goforward")
                })
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            }
            .font(.caption)
            .foregroundColor(Color.gray)
            .padding(.horizontal)
        }

}
