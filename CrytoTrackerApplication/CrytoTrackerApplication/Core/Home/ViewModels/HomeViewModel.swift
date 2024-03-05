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
    @Published var sortOption: SortOption = .holdings
    @Published var isLoading: Bool = false
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private let portfolioDataService = PortfolioDataService()
    enum SortOption {
          case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
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
                  .combineLatest(dataService.$allCoins, $sortOption)
                  .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                  .map(filterAndSortCoins)
                  .sink { [weak self] (returnedCoins) in
                      self?.allCoins = returnedCoins
                  }
                  .store(in: &cancellables)
              
              // updates portfolioCoins
              $allCoins
                  .combineLatest(portfolioDataService.$savedEntities)
                  .map(mapAllCoinsToPortfolioCoins)
                  .sink { [weak self] (returnedCoins) in
                      guard let self = self else { return }
                      self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
                  }
                  .store(in: &cancellables)
        
    }
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData() {
           isLoading = true
           dataService.getCoins()
           
       }
       
       private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
           var updatedCoins = filterCoins(text: text, coins: coins)
           sortCoins(sort: sort, coins: &updatedCoins)
           return updatedCoins
       }
       
       private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
           guard !text.isEmpty else {
               return coins
           }
           
           let lowercasedText = text.lowercased()
           
           return coins.filter { (coin) -> Bool in
               return coin.name.lowercased().contains(lowercasedText) ||
                       coin.symbol.lowercased().contains(lowercasedText) ||
                       coin.id.lowercased().contains(lowercasedText)
           }
       }
       
       private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
           switch sort {
           case .rank, .holdings:
               coins.sort(by: { $0.rank < $1.rank })
           case .rankReversed, .holdingsReversed:
               coins.sort(by: { $0.rank > $1.rank })
           case .price:
               coins.sort(by: { $0.currentPrice > $1.currentPrice })
           case .priceReversed:
               coins.sort(by: { $0.currentPrice < $1.currentPrice })
           }
       }
       
       private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
           // will only sort by holdings or reversedholdings if needed
           switch sortOption {
           case .holdings:
               return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
           case .holdingsReversed:
               return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
           default:
               return coins
           }
       }
       
       private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
           allCoins
               .compactMap { (coin) -> CoinModel? in
                   guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                       return nil
                   }
                   return coin.updateHoldings(amount: entity.amount)
               }
       }

  

    
    
}
