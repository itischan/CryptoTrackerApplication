//
//  SearchBarView.swift
//  CryptoTrackerApplication
//
//  Created by Judin Joseph on 2/13/24
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.green : Color.red
                )
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.red)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.blue)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            
                            searchText = ""
                        }
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray)
                .shadow(
                    color: Color.red.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}
#Preview {
    SearchBarView(searchText: .constant(""))
}
