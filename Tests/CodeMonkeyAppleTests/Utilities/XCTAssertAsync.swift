//
//  XCTAssertAsync.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 9/19/21.
//

import XCTest

// MARK: - Public Global Interface

public func XCTAssertEqualAsync<T>(
    _ expression1: @autoclosure () async throws -> T,
    _ expression2: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async rethrows where T: Equatable {
    let value1 = try await expression1()
    let value2 = try await expression2()
    XCTAssertEqual(value1, value2, message(), file: file, line: line)
}

public func XCTAssertNilAsync(
    _ expression: @autoclosure () async throws -> Any?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async rethrows {
    let value = try await expression()
    XCTAssertNil(value, message(), file: file, line: line)
}

public func XCTAssertNotNilAsync(
    _ expression: @autoclosure () async throws -> Any?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async rethrows {
    let value = try await expression()
    XCTAssertNotNil(value, message(), file: file, line: line)
}
