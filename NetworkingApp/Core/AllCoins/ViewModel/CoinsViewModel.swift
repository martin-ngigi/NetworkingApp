//
//  CoinsViewModel.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 17/11/2023.
//

import Foundation

class CoinsViewModel: ObservableObject{
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage : String?
    
    private let service = CoinDataService()
    @Published var coins = [Coin]()
    
    init() {
//        fetchPrice(coin: "litecoin")
        fetchCoins()
    }
    
    func fetchCoins(){
        /**
        service.fetchCoins { coins, error in
            DispatchQueue.self.main.async {
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    return
                }
                self.coins = coins ?? []
            }
        }
        **/
        
        service.fetchCoinsWithResults { [weak self]result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchPrice(coin: String){
        service.fetchPrice(coin: coin) { priceFromService in
            DispatchQueue.main.sync {
                print("---> Price from Service: \(priceFromService)")
                self.price = "\(priceFromService)"
                self.coin = coin
            }
        }
    }
    
}
