//
//  CoinDataService.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 17/11/2023.
//

import Foundation

class CoinDataService{
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h&locale=en"
    func fetchCoins(completion: @escaping([Coin]?, Error?) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(nil, error)
            }
            guard let data  = data else { return }
            /**
            let dataAsString = String(data: data, encoding: .utf8)
            print("---> dataAsString: \(dataAsString)")
             **/
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("*** Error: Failed to decode coin")
                return
            }
            
            /**
            for coin in coins{
                print("---> coin name: \(coin.name)")
            }
            **/
            
            //print("---> coin list: \(coins)")
            //print("---> coins count: \(coins.count)")
            
            completion(coins, nil)
        }.resume()
    }
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void){
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print("*** Error: \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
                return
            }
            //print("---> Did Receive data: \(data!)")
            guard let httpResponse = response as? HTTPURLResponse else {
//                    self.errorMessage = "Error: Bad Http response"
                print("*** Error: Bad Http response")
                return
            }
            
            guard httpResponse.statusCode == 200 else{
//                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode) "
                return
            }
            
            guard let data = data else {
                print("*** Error: Failed to pass data")
                return
            }
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
            
        
//                self.coin = coin.capitalized
//                self.price = "\(price)"
            completion(price)
        }.resume()
        
    }
}
