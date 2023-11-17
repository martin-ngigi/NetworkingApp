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
    
    init() {
        fetchCoin()
    }
    
    func fetchCoin(){
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=bitocoin&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("------> Did Receive data: \(data)")
        }.resume()
    }
    
}
