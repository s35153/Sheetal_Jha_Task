//
//  Models.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

// MARK: - API Response Models
struct HoldingsResponse: Codable {
    let data: HoldingsData
}

struct HoldingsData: Codable {
    let userHolding: [Holding]
}

// MARK: - Holding Model
struct Holding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    // Computed properties for calculations (as per mandatory formulas)
    
    /// Current value = LTP × quantity
    var currentValue: Double {
        return ltp * Double(quantity)
    }
    
    /// Total investment = Avg price × quantity
    var investmentValue: Double {
        return avgPrice * Double(quantity)
    }
    
    /// Total PnL = Current value − Total investment
    var totalPnL: Double {
        return currentValue - investmentValue
    }
    
    /// Today's PnL = (Close − LTP) × quantity
    var todaysPnL: Double {
        return (close - ltp) * Double(quantity)
    }
    
    var totalPnLPercentage: Double {
        guard investmentValue != 0 else { return 0 }
        return (totalPnL / investmentValue) * 100
    }
    
    var todaysPnLPercentage: Double {
        guard close != 0 else { return 0 }
        return (todaysPnL / (close * Double(quantity))) * 100
    }
}

// MARK: - Portfolio Summary Model
struct PortfolioSummary {
    let holdings: [Holding]
    
    /// Current value = Σ(LTP × quantity)
    var totalCurrentValue: Double {
        return holdings.reduce(0) { $0 + $1.currentValue }
    }
    
    /// Total investment = Σ(Avg price × quantity)
    var totalInvestmentValue: Double {
        return holdings.reduce(0) { $0 + $1.investmentValue }
    }
    
    /// Total PnL = Current value − Total investment
    var totalPnL: Double {
        return totalCurrentValue - totalInvestmentValue
    }
    
    /// Today's PnL = Σ((Close − LTP) × quantity)
    var todaysTotalPnL: Double {
        return holdings.reduce(0) { $0 + $1.todaysPnL }
    }
    
    var totalPnLPercentage: Double {
        guard totalInvestmentValue != 0 else { return 0 }
        return (totalPnL / totalInvestmentValue) * 100
    }
}
