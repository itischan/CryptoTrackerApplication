//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/9/21.
//

import Foundation
import Combine
class HomeViewModel:ObservableObject{
    @Published var allCoins :[CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    init(){
       getSubscribers()
    }
    func getSubscribers(){
        dataService.$allCoins
            .sink {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
