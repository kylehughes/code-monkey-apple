//
//  CLLocationCoordinate2DTests.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CodeMonkeyApple
import CoreLocation
import XCTest

final class CLLocationCoordinate2DTests: XCTestCase {
    // NO-OP
}

// MARK: - Conversion Tests

extension CLLocationCoordinate2DTests {
    // MARK: Decimal Degrees (DD) Combined Tests
    
    func test_init_decimalDegrees_combined_valid_generic() {
        let coordinate = CLLocationCoordinate2D(decimalDegrees: "45.678°N 98.765°W")
        XCTAssertEqual(coordinate?.latitude, 45.678)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }
    
    func test_init_decimalDegrees_combined_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(decimalDegrees: "90.000°N 180.000°E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }
    
    func test_init_decimalDegrees_combined_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(decimalDegrees: "90.000°S 180.000°W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }

    func test_init_decimalDegrees_combined_invalid_incorrectDegreesFormat() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "45.678°N 98°45′54″W"))
    }

    func test_init_decimalDegrees_combined_invalid_excessiveLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "1234.567°N 98.765°W"))
    }

    func test_init_decimalDegrees_combined_invalid_excessiveLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "45.678°N 198.765°W"))
    }

    func test_init_decimalDegrees_combined_invalid_randomText() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "random text"))
    }

    func test_init_decimalDegrees_combined_missingLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "98.765°W"))
    }

    func test_init_decimalDegrees_combined_missingLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegrees: "45.678°N"))
    }
    
    // MARK: Decimal Degrees (DD) Separated Tests
    
    func test_init_decimalDegrees_separated_valid_generic() {
        let coordinate = CLLocationCoordinate2D(decimalDegreesLatitude: "45.678°N", longitude: "98.765°W")
        XCTAssertEqual(coordinate?.latitude, 45.678)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }
    
    func test_init_decimalDegrees_separated_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(decimalDegreesLatitude: "90.000°S", longitude: "180.000°W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }

    func test_init_decimalDegrees_separated_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(decimalDegreesLatitude: "90.000°N", longitude: "180.000°E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }

    func test_init_decimalDegrees_separated_valid_centerBound() {
        let coordinate = CLLocationCoordinate2D(decimalDegreesLatitude: "0.000°N", longitude: "0.000°E")
        XCTAssertEqual(coordinate?.latitude, 0)
        XCTAssertEqual(coordinate?.longitude, 0)
    }

    func test_init_decimalDegrees_separated_invalid_latitudeFormat() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "12°34′56″N", longitude: "98.765°W"))
    }

    func test_init_decimalDegrees_separated_invalid_longitudeFormat() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "45.678°N", longitude: "98°45′54″W"))
    }

    func test_init_decimalDegrees_separated_invalid_excessiveLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "1234.567°N", longitude: "98.765°W"))
    }

    func test_init_decimalDegrees_separated_invalid_excessiveLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "45.678°N", longitude: "198.765°W"))
    }

    func test_init_decimalDegrees_separated_invalid_randomTextLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "random text", longitude: "98.765°W"))
    }

    func test_init_decimalDegrees_separated_invalid_randomTextLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(decimalDegreesLatitude: "45.678°N", longitude: "random text"))
    }
    
    // MARK: Degrees Decimal Minutes (DDM) Combined Tests
        
    func test_init_degreesDecimalMinutes_combined_valid_generic() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: "45°30.000′N 98°45.000′W")
        XCTAssertEqual(coordinate?.latitude, 45.5)
        XCTAssertEqual(coordinate?.longitude, -98.75)
    }
    
    func test_init_degreesDecimalMinutes_combined_valid_centerBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: "0°0.000′N 0°0.000′E")
        XCTAssertEqual(coordinate?.latitude, 0)
        XCTAssertEqual(coordinate?.longitude, 0)
    }
    
    func test_init_degreesDecimalMinutes_combined_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: "90°0.000′S 180°0.000′W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }
    
    func test_init_degreesDecimalMinutes_combined_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: "90°0.000′N 180°0.000′E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }

    func test_init_degreesDecimalMinutes_combined_invalid_DMSFormat() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "12°34′56″N 98°45′54″W"))
    }
    
    func test_init_degreesDecimalMinutes_combined_invalid_noDirection() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "1234.567′ 98.765′"))
    }
    
    func test_init_degreesDecimalMinutes_combined_invalid_exceedsBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "45.678′N 198.765′W"))
    }
    
    func test_init_degreesDecimalMinutes_combined_invalid_randomText() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "random text"))
    }
    
    func test_init_degreesDecimalMinutes_combined_invalid_partialRandomText() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "45°30.000′N random text"))
    }
    
    func test_init_degreesDecimalMinutes_combined_invalid_minutesOutOfBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutes: "90°60.000′N 180°60.000′E"))
    }
    
    // MARK: Degrees Decimal Minutes (DDM) Separated Tests

    func test_init_degreesDecimalMinutes_separated_valid_generic() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "45°30.000′N", longitude: "98°45.000′W")
        XCTAssertEqual(coordinate?.latitude, 45.5)
        XCTAssertEqual(coordinate?.longitude, -98.75)
    }
    
    func test_init_degreesDecimalMinutes_separated_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "90°00.000′S", longitude: "180°00.000′W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }

    func test_init_degreesDecimalMinutes_separated_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "90°00.000′N", longitude: "180°00.000′E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }

    func test_init_degreesDecimalMinutes_separated_valid_centerBound() {
        let coordinate = CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "0°00.000′N", longitude: "0°00.000′E")
        XCTAssertEqual(coordinate?.latitude, 0)
        XCTAssertEqual(coordinate?.longitude, 0)
    }

    func test_init_degreesDecimalMinutes_separated_invalid_latitudeFormat() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "12°34′56″N", longitude: "98°45.000′W"))
    }

    func test_init_degreesDecimalMinutes_separated_invalid_longitudeFormat() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "45°30.000′N", longitude: "98°45′54″W"))
    }

    func test_init_degreesDecimalMinutes_separated_invalid_excessiveLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "95°30.000′N", longitude: "98°45.000′W"))
    }

    func test_init_degreesDecimalMinutes_separated_invalid_excessiveLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "45°30.000′N", longitude: "185°45.000′W"))
    }

    func test_init_degreesDecimalMinutes_separated_invalid_randomTextLatitude() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "random text", longitude: "98°45.000′W"))
    }

    func test_init_degreesDecimalMinutes_separated_invalid_randomTextLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(degreesDecimalMinutesLatitude: "45°30.000′N", longitude: "random text"))
    }
    
    // MARK: Degrees Minutes Seconds (DMS) Together Tests

    func test_init_degreesMinutesSeconds_together_valid_generic() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: "45°30′0″N 98°45′0″W")
        XCTAssertEqual(coordinate?.latitude, 45.5)
        XCTAssertEqual(coordinate?.longitude, -98.75)
    }
    
    func test_init_degreesMinutesSeconds_together_valid_centerBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: "0°0′0″N 0°0′0″E")
        XCTAssertEqual(coordinate?.latitude, 0)
        XCTAssertEqual(coordinate?.longitude, 0)
    }
    
    func test_init_degreesMinutesSeconds_together_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: "90°0′0″S 180°0′0″W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }

    func test_init_degreesMinutesSeconds_together_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: "90°0′0″N 180°0′0″E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }

    func test_init_degreesMinutesSeconds_together_invalid_missingLongitude() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "45°30′0″N"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_DDMFormat() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "12°34.567′N 98°45.543′W"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_noDirection() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "12°34′56″ 98°45′54″"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_exceedsBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "91°0′0″N 181°0′0″E"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_randomText() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "random text"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_partialRandomText() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "45°30′0″N random text"))
    }
    
    func test_init_degreesMinutesSeconds_together_invalid_secondsOutOfBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSeconds: "90°0′60″N 180°0′60″E"))
    }
    
    // MARK: Degrees Minutes Seconds (DMS) Separated Tests

    func test_init_degreesMinutesSeconds_separated_valid_generic() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "45°30′0″N", longitude: "98°45′0″W")
        XCTAssertEqual(coordinate?.latitude, 45.5)
        XCTAssertEqual(coordinate?.longitude, -98.75)
    }
    
    func test_init_degreesMinutesSeconds_separated_valid_centerBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "0°0′0″N", longitude: "0°0′0″E")
        XCTAssertEqual(coordinate?.latitude, 0)
        XCTAssertEqual(coordinate?.longitude, 0)
    }

    func test_init_degreesMinutesSeconds_separated_valid_minBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "90°0′0″S", longitude: "180°0′0″W")
        XCTAssertEqual(coordinate?.latitude, -90)
        XCTAssertEqual(coordinate?.longitude, -180)
    }

    func test_init_degreesMinutesSeconds_separated_valid_maxBound() {
        let coordinate = CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "90°0′0″N", longitude: "180°0′0″E")
        XCTAssertEqual(coordinate?.latitude, 90)
        XCTAssertEqual(coordinate?.longitude, 180)
    }

    func test_init_degreesMinutesSeconds_separated_invalid_DDMFormat() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "12°34.567′N", longitude: "98°45.543′W"))
    }
    
    func test_init_degreesMinutesSeconds_separated_invalid_noDirection() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "12°34′56″", longitude: "98°45′54″"))
    }
    
    func test_init_degreesMinutesSeconds_separated_invalid_exceedsBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "91°0′0″N", longitude: "181°0′0″E"))
    }
    
    func test_init_degreesMinutesSeconds_separated_invalid_randomText() {
        XCTAssertNil(
            CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "random text", longitude: "more random text")
        )
    }
    
    func test_init_degreesMinutesSeconds_separated_invalid_partialRandomText() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "45°30′0″N", longitude: "random text"))
    }
    
    func test_init_degreesMinutesSeconds_separated_invalid_secondsOutOfBounds() {
        XCTAssertNil(CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "90°0′60″N", longitude: "180°0′60″E"))
    }
    
    // MARK: Flexible Format Combined Tests
    
    func test_init_flexibleFormat_combined_DD() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12.345°N 98.765°W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_combined_DDM() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20.7′N 98°45.9′W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_combined_DMS() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20′42″N 98°45′54″W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_combined_DD_DDM() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12.345°N 98°45.9′W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_DD_DMS() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12.345°N 98°45′54″W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_DDM_DD() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20.7′N 98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_DDM_DMS() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20.7′N 98°45′54″W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_DMS_DD() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20′42″N 98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_DMS_DDM() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12°20′42″N 98°45.9′W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_invalid() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12.345 98.765")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_invalid_latitudeOutOfBounds() {
        let coordinate = CLLocationCoordinate2D(coordinate: "92.345°N 98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_combined_invalid_longitudeOutOfBounds() {
        let coordinate = CLLocationCoordinate2D(coordinate: "12.345°N 198.765°W")
        XCTAssertNil(coordinate)
    }
    
    // MARK: Flexible Format Separated Tests
    
    func test_init_flexibleFormat_separated_DD_DD() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "98.765°W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_separated_DDM_DDM() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20.7′N", longitude: "98°45.9′W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_separated_DMS_DMS() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20′42″N", longitude: "98°45′54″W")
        XCTAssertEqual(coordinate?.latitude, 12.345)
        XCTAssertEqual(coordinate?.longitude, -98.765)
    }

    func test_init_flexibleFormat_separated_DD_DDM() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "98°45.9′W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_DD_DMS() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "98°45′54″W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_DDM_DD() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20.7′N", longitude: "98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_DDM_DMS() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20.7′N", longitude: "98°45′54″W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_DMS_DD() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20′42″N", longitude: "98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_DMS_DDM() {
        let coordinate = CLLocationCoordinate2D(latitude: "12°20′42″N", longitude: "98°45.9′W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_invalid_invalid() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345", longitude: "98.765")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_valid_invalid() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "98.765")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_invalid_valid() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345", longitude: "98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_latitudeOutOfBounds() {
        let coordinate = CLLocationCoordinate2D(latitude: "92.345°N", longitude: "98.765°W")
        XCTAssertNil(coordinate)
    }

    func test_init_flexibleFormat_separated_longitudeOutOfBounds() {
        let coordinate = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "198.765°W")
        XCTAssertNil(coordinate)
    }
}
