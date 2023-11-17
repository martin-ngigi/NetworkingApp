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
    
    init() {
        fetchCoin(coin: "litecoin")
    }
    
    func fetchCoin(coin: String){
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    print("*** Error: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    return
                }
                //print("---> Did Receive data: \(data!)")
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Error: Bad Http response"
                    print("*** Error: Bad Http response")
                    return
                }
                
                guard httpResponse.statusCode == 200 else{
                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode) "
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
                
            
                self.coin = coin.capitalized
                self.price = "\(price)"
            }
        }.resume()
        
    }
    
}
