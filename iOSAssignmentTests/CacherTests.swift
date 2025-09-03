//
//  CacherTests.swift
//  iOSAssignmentTests
//
//  Created by Lingaswami Karingula on 03/09/25.
//

import XCTest
@testable import iOSAssignment

final class CacherTests: XCTestCase {
    
    var cacher:Cacher!
    
    override func setUp() {
        super.setUp()
        cacher = Cacher()
    }
    
    override func tearDown() {
        cacher = nil
        super.tearDown()
    }
    
    func testCacheAndRetrieveResponse() {
        // Given
        let repo = Items(id: 1, name: "TestRepo", html_url: "https://github.com/test")
        let repos = [repo]
        
        do {
            // When
            try cacher.cacheResponse(repos)
            let cached = try cacher.getCachedResponse()
            
            // Then
            XCTAssertNotNil(cached)
            XCTAssertEqual(cached?.first?.name, "TestRepo")
        } catch {
            XCTFail("Caching failed with error: \(error)")
        }
    }
}
