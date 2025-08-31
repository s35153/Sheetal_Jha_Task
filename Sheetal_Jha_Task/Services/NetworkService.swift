//
//  NetworkService.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void)
}

// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
}

// MARK: - Network Service Implementation
class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
    private let session = URLSession.shared
    
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let holdingsResponse = try JSONDecoder().decode(HoldingsResponse.self, from: data)
                completion(.success(holdingsResponse.data.userHolding))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        task.resume()
    }
}
