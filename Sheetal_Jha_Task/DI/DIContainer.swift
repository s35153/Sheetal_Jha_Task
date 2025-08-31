//
//  DIContainer.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import UIKit

// MARK: - Dependency Injection Container
class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Services
    private lazy var networkService: NetworkServiceProtocol = NetworkService()
    private lazy var holdingsService: HoldingsServiceProtocol = HoldingsService(networkService: networkService)
    
    // MARK: - Factory Methods
    func makeHoldingsViewModel() -> HoldingsViewModelProtocol {
        return HoldingsViewModel(holdingsService: holdingsService)
    }
    
    func makeHoldingsViewController() -> UIViewController {
        let viewModel = makeHoldingsViewModel()
        return ViewController(viewModel: viewModel)
    }
}
