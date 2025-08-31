//
//  HoldingsService.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 29/08/25.
//

import Foundation

// MARK: - Holdings Service Implementation
class HoldingsService: HoldingsServiceProtocol {
    
    func fetchHoldings() -> [Holding] {
        return [
            Holding(symbol: "ASHOKLEY", quantity: 3, ltp: 119.10, avgPrice: 115.80, close: 118.50),
            Holding(symbol: "HDFC", quantity: 7, ltp: 2497.20, avgPrice: 2714.06, close: 2485.30),
            Holding(symbol: "ICICIBANK", quantity: 1, ltp: 624.70, avgPrice: 489.10, close: 620.15),
            Holding(symbol: "IDEA", quantity: 3, ltp: 9.95, avgPrice: 9.02, close: 9.85),
            Holding(symbol: "MARICO", quantity: 12, ltp: 653.45, avgPrice: 578.50, close: 645.10),
            Holding(symbol: "VBL", quantity: 1, ltp: 1033.85, avgPrice: 1054.70, close: 1028.20),
            Holding(symbol: "KPITTECH", quantity: 25, ltp: 1667.55, avgPrice: 1640.75, close: 1656.90),
            Holding(symbol: "BHARTIARTL", quantity: 8, ltp: 1222.50, avgPrice: 1201.35, close: 1215.80),
            Holding(symbol: "TATACONSUM", quantity: 15, ltp: 912.80, avgPrice: 923.45, close: 905.60),
            Holding(symbol: "RELIANCE", quantity: 5, ltp: 2845.30, avgPrice: 2780.20, close: 2832.15),
            Holding(symbol: "TCS", quantity: 3, ltp: 4123.75, avgPrice: 4089.60, close: 4110.25),
            Holding(symbol: "INFY", quantity: 7, ltp: 1834.20, avgPrice: 1798.45, close: 1821.90),
            Holding(symbol: "WIPRO", quantity: 20, ltp: 445.60, avgPrice: 461.80, close: 442.15),
            Holding(symbol: "HCLTECH", quantity: 6, ltp: 1598.35, avgPrice: 1612.90, close: 1591.20)
        ]
    }
}
