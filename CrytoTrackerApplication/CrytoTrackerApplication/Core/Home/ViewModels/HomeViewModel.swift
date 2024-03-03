//
//  HomeViewModel.swift
//  CryptoTrackerApplication
//
//  Created by Vinayak on 2/13/24
//

import Foundation
import Combine
class HomeViewModel:ObservableObject{
    @Published var allCoins :[CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String =  ""
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private let portfolioDataService = PortfolioDataService()
    init(){
       getSubscribers()
    }
    func getSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        // updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .map{(text,startingCoins)->[CoinModel] in
                guard !text.isEmpty else{return startingCoins}
                let lowercase = text.lowercased()
                let filteredCoins = startingCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(lowercase) ||
                    coin.symbol.lowercased().contains(lowercase)
                    
                }
                return filteredCoins
            }.sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //updates portfolio Coins
        
        $allCoins
                   .combineLatest(portfolioDataService.$savedEntities)
                   .map{(coinModels,portolioEntities) -> [CoinModel] in
                       coinModels.compactMap { (coin) -> CoinModel? in
                           guard let entity = portolioEntities.first(where: {$0.coinID == coin.id}) else{
                               return nil}
                           return coin.updateHoldings(amount: entity.amount)
                       }
                   }.sink {[weak self] returnedCoins in
                       self?.portfolioCoins = returnedCoins
                   }
                   .store(in: &cancellables)
        
    }
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
  

    
    
}
