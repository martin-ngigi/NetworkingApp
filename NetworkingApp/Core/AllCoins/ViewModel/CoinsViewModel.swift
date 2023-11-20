//
//  CoinsViewModel.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 17/11/2023.
//

import Foundation

class CoinsViewModel: ObservableObject{
    @Published var errorMessage : String?
    
    private let service = CoinDataService()
    @Published var coins = [Coin]()
    
    init() {
        Task{ try await fetchCoins() }
    }
    
    func fetchCoins() async throws{
        self.coins = try await service.fectchCoins()
    }
    
    func fetchCoinsWithCompletionHandler(){
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
}
