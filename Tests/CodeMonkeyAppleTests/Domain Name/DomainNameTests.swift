//
//  DomainNameTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 3/15/21.
//

import CodeMonkeyApple
import XCTest

final class DomainNameTests: XCTestCase {
    // MARK: - XCTestCase Implementation
    
    override func setUp() {
        // NO-OP
    }
    
    override func tearDown() {
        // NO-OP
    }
}

// MARK: - Tests

extension DomainNameTests {
    // MARK: Initialization Tests
    
    func test_init_rawValue_empty() {
        // Given…
        
        let rawValue = ""
        let tokens: [String] = []
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.tokens, tokens)
    }
    
    func test_init_rawValue_multiple() {
        // Given…
        
        let rawValue = "es.kylehugh.subdomain"
        let tokens = ["es", "kylehugh", "subdomain"]
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.tokens, tokens)
    }
    
    func test_init_rawValue_single() {
        // Given…
        
        let rawValue = "es"
        let tokens = [rawValue]
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.tokens, tokens)
    }
}
