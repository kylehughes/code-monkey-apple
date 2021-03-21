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
        let subdomains: [Subdomain] = [
        ]
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.subdomains, subdomains)
    }
    
    func test_init_rawValue_multiple() {
        // Given…
        
        let rawValue = "es.kylehugh.subdomain"
        let subdomains: [Subdomain] = [
            "es",
            "kylehugh",
            "subdomain"
        ]
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.subdomains, subdomains)
    }
    
    func test_init_rawValue_single() {
        // Given…
        
        let rawValue = "es"
        let subdomains: [Subdomain] = [
            Subdomain(rawValue: rawValue)
        ]
        
        // When…
        
        let domainName = DomainName(rawValue: rawValue)
        
        // Then…
        
        XCTAssertEqual(domainName.rawValue, rawValue)
        XCTAssertEqual(domainName.subdomains, subdomains)
    }
}
