//
//  PortfolioSummary+Calculations.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

extension PortfolioSummary {
    
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
