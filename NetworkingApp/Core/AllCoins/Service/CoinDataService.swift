//
//  CoinDataService.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 17/11/2023.
//

import Foundation

class CoinDataService{
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h&locale=en"
    func fectchCoins() async throws -> [Coin]{
        guard let url = URL(string: urlString) else {
            print("*** DEBUB : Error Wrong url")
            return []
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
        }
        catch{
            print("*** DEBUB : Error \(error.localizedDescription)")
            return []
        }
       
    }
}

// MARK: - Completion Handlers
extension CoinDataService {
    func fetchCoinsWithResults(completion: @escaping( Result<[Coin], CoinApiError>) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(.unknownError(error: error)))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed. ")))
                print("*** Error: Bad Http response")
                return
            }
            
            guard httpResponse.statusCode == 200 else{
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                print("*** Error: Bad Http response code: \(httpResponse.statusCode)")
                return
            }
            
            guard let data  = data else {
                completion(.failure(.invalidData))
                print("*** Error: Invalid data")
                return
            }
            
            do{
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            }
            catch{
                print("*** Error: Failed to decode coins with error: \(error)")
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
}
