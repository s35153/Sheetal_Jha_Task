//
//  HoldingsViewModel.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

class HoldingsViewModel: HoldingsViewModelProtocol {
    
    // MARK: - Properties
    private var holdings: [Holding] = []
    private let holdingsService: HoldingsServiceProtocol
    
    // MARK: - Callbacks
    var onDataLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?
    
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
        holdingsService.fetchHoldings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let holdings):
                    self?.holdings = holdings
                    self?.onDataLoaded?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
