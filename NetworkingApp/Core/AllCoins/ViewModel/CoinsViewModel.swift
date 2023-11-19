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
    
    init() {
//        fetchPrice(coin: "litecoin")
        fetchCoins()
    }
    
    func fetchCoins(){
        service.fetchCoins()
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
