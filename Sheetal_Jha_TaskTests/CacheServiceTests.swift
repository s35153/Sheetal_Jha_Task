//
//  CacheServiceTests.swift
//  Sheetal_Jha_TaskTests
//
//  Created by Sheetal Jha on 31/08/25.
//

import XCTest
@testable import Sheetal_Jha_Task

final class CacheServiceTests: XCTestCase {
    
    var cacheService: CacheService!
    let cacheKey = "cached_holdings" // Use the same key as CacheService
    
    override func setUpWithError() throws {
        cacheService = CacheService()
        // Clear any existing cached data
        UserDefaults.standard.removeObject(forKey: cacheKey)
    }
    
    override func tearDownWithError() throws {
        // Clean up test data
        UserDefaults.standard.removeObject(forKey: cacheKey)
        cacheService = nil
    }
    
    func testSaveAndLoadHoldings() {
        // Given
        let testHoldings = TestDataFactory.createTestHoldings()
        
        // When
        cacheService.saveHoldings(testHoldings)
        let loadedHoldings = cacheService.loadCachedHoldings()
        
        // Then
        XCTAssertNotNil(loadedHoldings, "Should load cached holdings")
        XCTAssertEqual(loadedHoldings?.count, 2, "Should load correct number of holdings")
        XCTAssertEqual(loadedHoldings?[0].symbol, "TEST1", "Should load correct first holding")
        XCTAssertEqual(loadedHoldings?[1].symbol, "TEST2", "Should load correct second holding")
    }
    
    func testHasCachedData() {
        // Given - no cached data initially
        XCTAssertFalse(cacheService.hasCachedData(), "Should not have cached data initially")
        
        // When - save some data
        let testHoldings = [TestDataFactory.createSingleTestHolding()]
        cacheService.saveHoldings(testHoldings)
        
        // Then
        XCTAssertTrue(cacheService.hasCachedData(), "Should have cached data after saving")
    }
    
    func testLoadCachedHoldingsWhenEmpty() {
        // Given - no cached data
        
        // When
        let loadedHoldings = cacheService.loadCachedHoldings()
        
        // Then
        XCTAssertNil(loadedHoldings, "Should return nil when no cached data")
        XCTAssertFalse(cacheService.hasCachedData(), "Should not have cached data")
    }
    
    func testSaveEmptyHoldings() {
        // Given
        let emptyHoldings: [Holding] = []
        
        // When
        cacheService.saveHoldings(emptyHoldings)
        let loadedHoldings = cacheService.loadCachedHoldings()
        
        // Then
        XCTAssertNotNil(loadedHoldings, "Should load empty array")
        XCTAssertEqual(loadedHoldings?.count, 0, "Should load empty holdings array")
        XCTAssertTrue(cacheService.hasCachedData(), "Should have cached data even if empty")
    }
}
