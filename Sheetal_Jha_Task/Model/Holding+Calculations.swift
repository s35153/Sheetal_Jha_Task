//
//  Holding+Calculations.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

extension Holding {
    
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
