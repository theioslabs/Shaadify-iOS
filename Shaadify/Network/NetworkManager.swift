//
//  NetworkManager.swift
//  ShaadifyApp
//
//  Created by Sushobhit Jain on 20/08/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endPoint: APIClient) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T>(endPoint: APIClient) async throws -> T where T : Decodable {
        
        guard let url = URL(string: endPoint.urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
            
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

