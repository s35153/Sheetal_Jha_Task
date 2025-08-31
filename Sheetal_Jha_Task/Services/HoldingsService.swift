//
//  HoldingsService.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

// MARK: - Holdings Service Implementation
class HoldingsService: HoldingsServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        // Simply try network request first
        networkService.fetchHoldings { [weak self] result in
            switch result {
            case .success(let holdings):
                // Cache the fresh data
                self?.cacheService.saveHoldings(holdings)
                completion(.success(holdings))
                
            case .failure(let error):
                // Try to load from cache if network fails
                if let cachedHoldings = self?.cacheService.loadCachedHoldings() {
                    print("Network failed, using cached data")
                    completion(.success(cachedHoldings))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
