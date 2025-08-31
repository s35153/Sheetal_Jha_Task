//
//  Models.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 29/08/25.
//

import Foundation

// MARK: - Holding Model
struct Holding {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    // Computed properties for calculations
    var currentValue: Double {
        return ltp * Double(quantity)
    }
    
    var investmentValue: Double {
        return avgPrice * Double(quantity)
    }
    
    var totalPnL: Double {
        return currentValue - investmentValue
    }
    
    var todaysPnL: Double {
        return (ltp - close) * Double(quantity)
    }
    
    var totalPnLPercentage: Double {
        guard investmentValue != 0 else { return 0 }
        return (totalPnL / investmentValue) * 100
    }
    
    var todaysPnLPercentage: Double {
        guard close != 0 else { return 0 }
        return ((ltp - close) / close) * 100
    }
}

// MARK: - Portfolio Summary Model
struct PortfolioSummary {
    let holdings: [Holding]
    
    var totalCurrentValue: Double {
        return holdings.reduce(0) { $0 + $1.currentValue }
    }
    
    var totalInvestmentValue: Double {
        return holdings.reduce(0) { $0 + $1.investmentValue }
    }
    
    var totalPnL: Double {
        return totalCurrentValue - totalInvestmentValue
    }
    
    var todaysTotalPnL: Double {
        return holdings.reduce(0) { $0 + $1.todaysPnL }
    }
    
    var totalPnLPercentage: Double {
        guard totalInvestmentValue != 0 else { return 0 }
        return (totalPnL / totalInvestmentValue) * 100
    }
}
