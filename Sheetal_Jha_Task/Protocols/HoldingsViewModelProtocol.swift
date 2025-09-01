//
//  HoldingsViewModelProtocol.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

protocol HoldingsViewModelProtocol {
    var numberOfHoldings: Int { get }
    func holding(at index: Int) -> Holding
    func loadHoldings()
}
