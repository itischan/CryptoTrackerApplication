//
//  SettingsView.swift
//  CrytoTrackerApplication
//
//  Created by ck on 2024-04-08.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL = URL(string: "https://www.google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/itischan")!
    var body: some View {
        ZStack{
            //Background
            Color.theme.background.ignoresSafeArea()
            //Content
            List{
                headerSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
                coinGeckoSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
               developerSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
                applicationSection
                     .listRowBackground(Color.theme.background.opacity(0.5))
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView{
    private var headerSection:some View{
        VStack(alignment: .leading) {
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
            Text("This App was created by 3 Students for their Capstone Project.It uses MVVM architecture,Combine and Core Data")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.theme.accent)
            

                                       
        }.padding(.vertical)
                                       
    }
    private var coinGeckoSection: some View {
            Section(header: Text("CoinGecko")) {
                VStack(alignment: .leading) {
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.accent)
                }
                .padding(.vertical)
                Link("Visit CoinGecko 🦎", destination: coingeckoURL)
            }
        }
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This application is developed by Chandru Kumaran.It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🤙",destination: githubURL)
        }
        
        
        
        
    }
    private var applicationSection: some View {
            Section(header: Text("Application")) {
                Link("Terms of Service", destination: defaultURL)
                Link("Privacy Policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn More", destination: defaultURL)
            }
        }

}
