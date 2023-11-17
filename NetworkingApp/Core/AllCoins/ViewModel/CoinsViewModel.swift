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
        fetchCoin(coin: "litecoin")
    }
    
    func fetchCoin(coin: String){
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        print("---> Fetching price")
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("---> Did Receive data: \(data)")
            guard let data = data else { return }
            /// Convert to Json object
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("*** Error: Failed to pass jsonObject")
                return
            }
            print("---> JSON: \(jsonObject)") /// in jsonObject remove as? [String: Any] which is type casting
            
            guard let value = jsonObject["\(coin)"] as? [String: Double] else {
                print("*** Error: Failed to pass value")
                return
            }
            guard let price = value["usd"] else {
                print("*** Error: Failed to pass price")
                return
            }
            
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "\(price)"
            }
        }.resume()
        
        print("---> Did reach end of function.")

    }
    
}
