//
//  HoldingsServiceTests.swift
//  Sheetal_Jha_TaskTests
//
//  Created by Sheetal Jha on 31/08/25.
//

import XCTest
@testable import Sheetal_Jha_Task

// MARK: - Mock Network Service
class MockNetworkService: NetworkServiceProtocol {
    
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

// MARK: - Mock Cache Service
class MockCacheService: CacheServiceProtocol {
    
    var cachedHoldings: [Holding]?
    var saveHoldingsCalled = false
    var loadCachedHoldingsCalled = false
    
    func saveHoldings(_ holdings: [Holding]) {
        saveHoldingsCalled = true
        cachedHoldings = holdings
    }
    
    func loadCachedHoldings() -> [Holding]? {
        loadCachedHoldingsCalled = true
        return cachedHoldings
    }
    
    func hasCachedData() -> Bool {
        return cachedHoldings != nil
    }
}

final class HoldingsServiceTests: XCTestCase {
    
    var holdingsService: HoldingsService!
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        holdingsService = HoldingsService(networkService: mockNetworkService, cacheService: mockCacheService)
    }
    
    override func tearDownWithError() throws {
        holdingsService = nil
        mockNetworkService = nil
        mockCacheService = nil
    }
    
    func testFetchHoldingsSuccess() {
        // Given
        let testHoldings = [TestDataFactory.createSingleTestHolding()]
        mockNetworkService.mockHoldings = testHoldings
        mockNetworkService.shouldSucceed = true
        
        let expectation = XCTestExpectation(description: "Holdings fetched")
        
        // When
        holdingsService.fetchHoldings { result in
            switch result {
            case .success(let holdings):
                XCTAssertEqual(holdings.count, 1)
                XCTAssertEqual(holdings[0].symbol, "TEST")
                expectation.fulfill()
            case .failure:
                XCTFail("Should not fail")
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockNetworkService.fetchHoldingsCalled, "Should call network service")
        XCTAssertTrue(mockCacheService.saveHoldingsCalled, "Should cache successful response")
    }
    
    func testFetchHoldingsNetworkFailureWithCache() {
        // Given - network will fail but cache has data
        mockNetworkService.shouldSucceed = false
        let cachedHoldings = [TestDataFactory.createCachedTestHolding()]
        mockCacheService.cachedHoldings = cachedHoldings
        
        let expectation = XCTestExpectation(description: "Cached holdings returned")
        
        // When
        holdingsService.fetchHoldings { result in
            switch result {
            case .success(let holdings):
                XCTAssertEqual(holdings.count, 1)
                XCTAssertEqual(holdings[0].symbol, "CACHED")
                expectation.fulfill()
            case .failure:
                XCTFail("Should return cached data, not fail")
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockNetworkService.fetchHoldingsCalled, "Should try network first")
        XCTAssertTrue(mockCacheService.loadCachedHoldingsCalled, "Should load from cache on network failure")
    }
    
    func testFetchHoldingsNetworkFailureWithoutCache() {
        // Given - network will fail and no cache
        mockNetworkService.shouldSucceed = false
        mockCacheService.cachedHoldings = nil
        
        let expectation = XCTestExpectation(description: "Error returned")
        
        // When
        holdingsService.fetchHoldings { result in
            switch result {
            case .success:
                XCTFail("Should fail when no network and no cache")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockNetworkService.fetchHoldingsCalled, "Should try network first")
        XCTAssertTrue(mockCacheService.loadCachedHoldingsCalled, "Should try cache on network failure")
    }
    
    func testOfflineSupport() {
        // Given - simulate successful network call first to populate cache
        let networkHoldings = [TestDataFactory.createSingleTestHolding()]
        mockNetworkService.mockHoldings = networkHoldings
        mockNetworkService.shouldSucceed = true
        
        let firstExpectation = XCTestExpectation(description: "First fetch success")
        
        // When - first successful fetch
        holdingsService.fetchHoldings { result in
            if case .success = result {
                firstExpectation.fulfill()
            }
        }
        
        wait(for: [firstExpectation], timeout: 1.0)
        
        // Then simulate network failure - should use cached data
        mockNetworkService.shouldSucceed = false
        let secondExpectation = XCTestExpectation(description: "Second fetch uses cache")
        
        holdingsService.fetchHoldings { result in
            switch result {
            case .success(let holdings):
                XCTAssertEqual(holdings[0].symbol, "TEST", "Should return cached data")
                secondExpectation.fulfill()
            case .failure:
                XCTFail("Should use cached data")
            }
        }
        
        wait(for: [secondExpectation], timeout: 1.0)
    }
}
