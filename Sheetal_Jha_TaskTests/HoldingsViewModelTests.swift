//
//  HoldingsViewModelTests.swift
//  Sheetal_Jha_TaskTests
//
//  Created by Sheetal Jha on 31/08/25.
//

import XCTest
@testable import Sheetal_Jha_Task

// MARK: - Mock Holdings Service
class MockHoldingsService: HoldingsServiceProtocol {
    
    var shouldSucceed = true
    var mockHoldings: [Holding] = []
    var fetchHoldingsCalled = false
    
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        fetchHoldingsCalled = true
        
        if shouldSucceed {
            completion(.success(mockHoldings))
        } else {
            completion(.failure(NetworkError.networkError(NSError(domain: "TestError", code: 1))))
        }
    }
}

final class HoldingsViewModelTests: XCTestCase {
    
    var viewModel: HoldingsViewModel!
    var mockService: MockHoldingsService!
    
    override func setUpWithError() throws {
        mockService = MockHoldingsService()
        viewModel = HoldingsViewModel(holdingsService: mockService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    func testInitialState() {
        // Given - fresh view model
        
        // When & Then
        XCTAssertEqual(viewModel.numberOfHoldings, 0, "Should start with no holdings")
    }
    
    func testLoadHoldingsSuccess() {
        // Given
        let testHoldings = TestDataFactory.createTestHoldings()
        mockService.mockHoldings = testHoldings
        mockService.shouldSucceed = true
        
        let expectation = XCTestExpectation(description: "Data loaded")
        
        // When
        viewModel.onDataLoaded = {
            expectation.fulfill()
        }
        
        viewModel.loadHoldings()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(mockService.fetchHoldingsCalled, "Should call service")
        XCTAssertEqual(viewModel.numberOfHoldings, 2, "Should have correct number of holdings")
        XCTAssertEqual(viewModel.holding(at: 0).symbol, "TEST1", "Should have correct first holding")
        XCTAssertEqual(viewModel.holding(at: 1).symbol, "TEST2", "Should have correct second holding")
    }
    
    func testLoadHoldingsFailure() {
        // Given
        mockService.shouldSucceed = false
        
        let expectation = XCTestExpectation(description: "Error occurred")
        
        // When
        viewModel.onError = { error in
            expectation.fulfill()
        }
        
        viewModel.loadHoldings()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(mockService.fetchHoldingsCalled, "Should call service")
        XCTAssertEqual(viewModel.numberOfHoldings, 0, "Should have no holdings on error")
    }
    
    func testHoldingAtIndex() {
        // Given
        let testHoldings = [TestDataFactory.createAppleTestHolding()]
        mockService.mockHoldings = testHoldings
        
        let expectation = XCTestExpectation(description: "Data loaded")
        viewModel.onDataLoaded = { expectation.fulfill() }
        
        // When
        viewModel.loadHoldings()
        wait(for: [expectation], timeout: 1.0)
        
        let holding = viewModel.holding(at: 0)
        
        // Then
        XCTAssertEqual(holding.symbol, "APPLE")
        XCTAssertEqual(holding.quantity, 10)
        XCTAssertEqual(holding.ltp, 150.0)
    }
}
