//
//  CacheServiceProtocol.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

protocol CacheServiceProtocol {
    func saveHoldings(_ holdings: [Holding])
    func loadCachedHoldings() -> [Holding]?
    func hasCachedData() -> Bool
}
