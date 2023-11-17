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
            if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
            }else{
                Text("\(viewModel.coin): \(viewModel.price)")
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
