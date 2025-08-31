//
//  HoldingsViewModel.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 29/08/25.
//

import Foundation

class HoldingsViewModel: HoldingsViewModelProtocol {
    
    // MARK: - Properties
    private var holdings: [Holding] = []
    private let holdingsService: HoldingsServiceProtocol
    
    // MARK: - Initialization
    init(holdingsService: HoldingsServiceProtocol) {
        self.holdingsService = holdingsService
    }
    
    // MARK: - Public Methods
    var numberOfHoldings: Int {
        return holdings.count
    }
    
    func holding(at index: Int) -> Holding {
        return holdings[index]
    }
    
    func loadHoldings() {
        holdings = holdingsService.fetchHoldings()
    }
}
