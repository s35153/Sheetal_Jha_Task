//
//  APIResponseModels.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

struct HoldingsResponse: Codable {
    let data: HoldingsData
}

struct HoldingsData: Codable {
    let userHolding: [Holding]
}
