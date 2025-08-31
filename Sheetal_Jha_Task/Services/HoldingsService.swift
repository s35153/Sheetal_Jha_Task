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
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        networkService.fetchHoldings(completion: completion)
    }
}
