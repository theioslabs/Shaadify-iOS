//
//  NetworkError.swift
//  MatrimonialApp
//
//  Created by Sushobhit Jain on 20/08/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidToken
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid server response"
        case .invalidToken: return "Failed to get authentication token"
        case .decodingError: return "Failed to decode the response"
        }
    }
}
