//
//  Holding.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

struct Holding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}
