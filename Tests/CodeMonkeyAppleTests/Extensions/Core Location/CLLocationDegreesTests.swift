//
//  CLLocationDegreesTests.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CoreLocation
import CodeMonkeyApple
import XCTest

final class CLLocationDegreesTests: XCTestCase {
    // NO-OP
}

// MARK: - Conversion Tests

extension CLLocationDegreesTests {
    // MARK: Decimal Degrees (DD) Tests

    func test_init_decimalDegrees_valid_positiveLatitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "12.345°N")
        XCTAssertEqual(degrees, 12.345)
    }

    func test_init_decimalDegrees_valid_positiveLongitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "98.765°E")
        XCTAssertEqual(degrees, 98.765)
    }

    func test_init_decimalDegrees_valid_negativeLatitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "12.345°S")
        XCTAssertEqual(degrees, -12.345)
    }

    func test_init_decimalDegrees_valid_negativeLongitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "98.765°W")
        XCTAssertEqual(degrees, -98.765)
    }

    func test_init_decimalDegrees_valid_zeroLatitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "0.000°N")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_decimalDegrees_valid_zeroLongitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "0.000°E")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_decimalDegrees_valid_maxPositiveLongitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "180.000°E")
        XCTAssertEqual(degrees, 180)
    }

    func test_init_decimalDegrees_valid_maxNegativeLongitude() {
        let degrees = CLLocationDegrees(decimalDegrees: "180.000°W")
        XCTAssertEqual(degrees, -180)
    }

    func test_init_decimalDegrees_invalid_invalidFormat() {
        let degrees = CLLocationDegrees(decimalDegrees: "12.345X")
        XCTAssertNil(degrees)
    }

    func test_init_decimalDegrees_invalid_invalidDirectionSymbol() {
        let degrees = CLLocationDegrees(decimalDegrees: "12.345'N")
        XCTAssertNil(degrees)
    }

    func test_init_decimalDegrees_invalid_missingDirectionSymbol() {
        let degrees = CLLocationDegrees(decimalDegrees: "°N")
        XCTAssertNil(degrees)
    }

    func test_init_decimalDegrees_invalid_emptyString() {
        let degrees = CLLocationDegrees(decimalDegrees: "")
        XCTAssertNil(degrees)
    }

    func test_init_decimalDegrees_invalid_nonNumericDegrees() {
        let degrees = CLLocationDegrees(decimalDegrees: "XYZ°N")
        XCTAssertNil(degrees)
    }

    // MARK: Degrees Decimal Minutes (DDM) Tests

    func test_init_degreesDecimalMinutes_valid_positiveLatitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesDecimalMinutes: "12°34.567'N"))
        XCTAssertEqual(degrees, 12 + (34.567 / 60), accuracy: 0.00001)
    }

    func test_init_degreesDecimalMinutes_valid_positiveLongitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesDecimalMinutes: "98°45.543'E"))
        XCTAssertEqual(degrees, 98 + (45.543 / 60), accuracy: 0.00001)
    }

    func test_init_degreesDecimalMinutes_valid_negativeLatitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesDecimalMinutes: "12°34.567'S"))
        XCTAssertEqual(degrees, -1 * (12 + (34.567 / 60)), accuracy: 0.00001)
    }

    func test_init_degreesDecimalMinutes_valid_negativeLongitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesDecimalMinutes: "98°45.543'W"))
        XCTAssertEqual(degrees, -1 * (98 + (45.543 / 60)), accuracy: 0.00001)
    }

    func test_init_degreesDecimalMinutes_valid_zeroLatitude() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "0°0.000'N")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_degreesDecimalMinutes_valid_zeroLongitude() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "0°0.000'E")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_degreesDecimalMinutes_invalid_invalidFormat() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "12°34.567X")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_invalidDirectionSymbol() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "12°34.567'X")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_missingDirectionSymbol() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "°'N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_emptyString() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_nonNumericDegrees() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "XYZ°12.345'N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_nonNumericMinutes() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "12°XYZ'N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesDecimalMinutes_invalid_minutesOutOfBounds() {
        let degrees = CLLocationDegrees(degreesDecimalMinutes: "12°60.1'N")
        XCTAssertNil(degrees)
    }
    
    // MARK: Degrees, Minutes, Seconds (DMS) Tests

    func test_init_degreesMinutesSeconds_valid_positiveLatitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesMinutesSeconds: "12°34′56″N"))
        XCTAssertEqual(degrees, 12 + (34 / 60) + (56 / 3600), accuracy: 0.00001)
    }

    func test_init_degreesMinutesSeconds_valid_positiveLongitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesMinutesSeconds: "98°45′54″E"))
        XCTAssertEqual(degrees, 98 + (45 / 60) + (54 / 3600), accuracy: 0.00001)
    }

    func test_init_degreesMinutesSeconds_valid_negativeLatitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesMinutesSeconds: "12°34′56″S"))
        XCTAssertEqual(degrees, -1 * (12 + (34 / 60) + (56 / 3600) as Double), accuracy: 0.00001)
    }

    func test_init_degreesMinutesSeconds_valid_negativeLongitude() throws {
        let degrees = try XCTUnwrap(CLLocationDegrees(degreesMinutesSeconds: "98°45′54″W"))
        XCTAssertEqual(degrees, -1 * (98 + (45 / 60) + (54 / 3600) as Double), accuracy: 0.00001)
    }

    func test_init_degreesMinutesSeconds_valid_zeroLatitude() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "0°0′0″N")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_degreesMinutesSeconds_valid_zeroLongitude() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "0°0′0″E")
        XCTAssertEqual(degrees, 0)
    }

    func test_init_degreesMinutesSeconds_invalid_invalidFormat() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°34′56X")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_invalidDirectionSymbol() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°34′56″X")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_missingDirectionSymbol() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "°′″N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_emptyString() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_nonNumericDegrees() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "XYZ°12′34″N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_nonNumericMinutes() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°XYZ′34″N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_nonNumericSeconds() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°34′XYZ″N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_minutesOutOfBounds() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°60′34″N")
        XCTAssertNil(degrees)
    }

    func test_init_degreesMinutesSeconds_invalid_secondsOutOfBounds() {
        let degrees = CLLocationDegrees(degreesMinutesSeconds: "12°34′60″N")
        XCTAssertNil(degrees)
    }
}
