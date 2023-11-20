//
//  ContentView.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 17/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    
    var body: some View {
        VStack {
            /**
            if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
            }else{
                Text("\(viewModel.coin): \(viewModel.price)")
            }
            **/
            List{
                ForEach(viewModel.coins){
                    coin in
                    HStack(spacing: 12){
                        Text("\(coin.marketCapRank)")
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(coin.name)
                                .fontWeight(.semibold)
                            
                            Text(coin.symbol.uppercased())
                        }
                    }.font(.footnote)
                }
            }.overlay{
                if let error = viewModel.errorMessage{
                    Text(error)
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
