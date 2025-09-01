//
//  TestHelpers.swift
//  Sheetal_Jha_TaskTests
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation
@testable import Sheetal_Jha_Task

// MARK: - Test Data Factory
struct TestDataFactory {
    
    // Standard test holdings for consistent testing
    static func createTestHoldings() -> [Holding] {
        return [
            Holding(symbol: "TEST1", quantity: 100, ltp: 50.0, avgPrice: 40.0, close: 45.0),
            Holding(symbol: "TEST2", quantity: 50, ltp: 100.0, avgPrice: 80.0, close: 90.0)
        ]
    }
    
    static func createSingleTestHolding() -> Holding {
        return Holding(symbol: "TEST", quantity: 100, ltp: 50.0, avgPrice: 40.0, close: 45.0)
    }
    
    static func createCachedTestHolding() -> Holding {
        return Holding(symbol: "CACHED", quantity: 50, ltp: 25.0, avgPrice: 20.0, close: 22.0)
    }
    
    static func createAppleTestHolding() -> Holding {
        return Holding(symbol: "APPLE", quantity: 10, ltp: 150.0, avgPrice: 140.0, close: 145.0)
    }
    
    // Test holdings with specific calculations for verification
    static func createCalculationTestHolding() -> Holding {
        // This creates a holding with known calculation results:
        // Current value = 50.0 × 100 = 5000.0
        // Investment value = 40.0 × 100 = 4000.0
        // Total PnL = 5000.0 - 4000.0 = 1000.0
        // Today's PnL = (45.0 - 50.0) × 100 = -500.0
        return Holding(symbol: "CALC_TEST", quantity: 100, ltp: 50.0, avgPrice: 40.0, close: 45.0)
    }
}
