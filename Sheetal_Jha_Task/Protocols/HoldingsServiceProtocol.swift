//
//  HoldingsServiceProtocol.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import Foundation

// MARK: - Holdings Service Protocol
protocol HoldingsServiceProtocol {
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void)
}

// MARK: - Holdings View Model Protocol
protocol HoldingsViewModelProtocol {
    var numberOfHoldings: Int { get }
    func holding(at index: Int) -> Holding
    func loadHoldings()
}
