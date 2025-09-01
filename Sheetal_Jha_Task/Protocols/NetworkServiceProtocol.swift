//
//  NetworkServiceProtocol.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 01/09/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void)
}
