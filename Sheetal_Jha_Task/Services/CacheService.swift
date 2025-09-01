//
//  CacheService.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation


class CacheService: CacheServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let cacheKey = "cached_holdings"
    
    func saveHoldings(_ holdings: [Holding]) {
        do {
            let data = try JSONEncoder().encode(holdings)
            userDefaults.set(data, forKey: cacheKey)
        } catch {
            print("Failed to cache holdings: \(error)")
        }
    }
    
    func loadCachedHoldings() -> [Holding]? {
        guard let data = userDefaults.data(forKey: cacheKey) else {
            return nil
        }
        do {
            let holdings = try JSONDecoder().decode([Holding].self, from: data)
            return holdings
        } catch {
            print("Failed to load cached holdings: \(error)")
            return nil
        }
    }
    
    func hasCachedData() -> Bool {
        return userDefaults.data(forKey: cacheKey) != nil
    }
}
