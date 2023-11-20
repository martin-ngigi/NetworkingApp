//
//  CoinApiError.swift
//  NetworkingApp
//
//  Created by Martin Wainaina on 20/11/2023.
//

import Foundation

enum CoinApiError: Error{
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String{
        switch self{
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Failed to parse JSON"
        case let .requestFailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid status sode: \(statusCode)"
        case let .unknownError(error): return "unknown Error: \(error.localizedDescription)"
            
        }
    }
}
