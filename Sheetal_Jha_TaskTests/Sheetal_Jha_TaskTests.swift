//
//  Sheetal_Jha_TaskTests.swift
//  Sheetal_Jha_TaskTests
//
//  Created by Sheetal Jha on 31/08/25.
//

import XCTest
@testable import Sheetal_Jha_Task

final class Sheetal_Jha_TaskTests: XCTestCase {

    // MARK: - Model Tests
    
    func testHoldingCalculations() {
        // Given
        let holding = TestDataFactory.createCalculationTestHolding()
        
        // When & Then - Test all calculations as per requirements
        
        // Current value = LTP × quantity
        XCTAssertEqual(holding.currentValue, 5000.0, accuracy: 0.01, "Current value calculation incorrect")
        
        // Total investment = Avg price × quantity
        XCTAssertEqual(holding.investmentValue, 4000.0, accuracy: 0.01, "Investment value calculation incorrect")
        
        // Total PnL = Current value − Total investment
        XCTAssertEqual(holding.totalPnL, 1000.0, accuracy: 0.01, "Total P&L calculation incorrect")
        
        // Today's PnL = (Close − LTP) × quantity
        XCTAssertEqual(holding.todaysPnL, -500.0, accuracy: 0.01, "Today's P&L calculation incorrect")
        
        // Test percentage calculations
        XCTAssertEqual(holding.totalPnLPercentage, 25.0, accuracy: 0.01, "Total P&L percentage incorrect")
    }
    
    func testPortfolioSummaryCalculations() {
        // Given
        let holdings = TestDataFactory.createTestHoldings()
        let portfolio = PortfolioSummary(holdings: holdings)
        
        // When & Then
        // Total current value = Σ(LTP × quantity) = (50×100) + (100×50) = 10000
        XCTAssertEqual(portfolio.totalCurrentValue, 10000.0, accuracy: 0.01)
        
        // Total investment = Σ(Avg price × quantity) = (40×100) + (80×50) = 8000
        XCTAssertEqual(portfolio.totalInvestmentValue, 8000.0, accuracy: 0.01)
        
        // Total PnL = Current value − Total investment = 10000 - 8000 = 2000
        XCTAssertEqual(portfolio.totalPnL, 2000.0, accuracy: 0.01)
        
        // Today's PnL = Σ((Close − LTP) × quantity) = ((45-50)×100) + ((90-100)×50) = -1000
        XCTAssertEqual(portfolio.todaysTotalPnL, -1000.0, accuracy: 0.01)
    }
    
    func testHoldingEdgeCases() {
        // Test zero quantity
        let zeroQuantity = Holding(symbol: "ZERO", quantity: 0, ltp: 100.0, avgPrice: 80.0, close: 90.0)
        XCTAssertEqual(zeroQuantity.currentValue, 0.0)
        XCTAssertEqual(zeroQuantity.investmentValue, 0.0)
        XCTAssertEqual(zeroQuantity.totalPnL, 0.0)
        
        // Test zero prices
        let zeroPrices = Holding(symbol: "ZERO_PRICE", quantity: 100, ltp: 0.0, avgPrice: 0.0, close: 0.0)
        XCTAssertEqual(zeroPrices.totalPnLPercentage, 0.0, "Should handle zero division gracefully")
    }

}
