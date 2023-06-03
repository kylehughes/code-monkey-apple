//
//  SaveToHealthError.swift
//  Models
//
//  Created by Kyle Hughes on 3/24/21.
//

#if canImport(HealthKit)

import HealthKit

@available(macOS 13.0, *)
public enum HealthKitError {
    // NO-OP
}

// MARK: - HealthKitError.Authorization Definition

@available(macOS 13.0, *)
extension HealthKitError {
    public enum Authorization: Error {
        case frameworkError(HKError)
        case frameworkFailedInternally
        case unknownError(Error)
        case userIgnored
    }
}

// MARK: - HealthKitError.Authorization Definition

@available(macOS 13.0, *)
extension HealthKitError {
    public enum AuthorizationAndPersistence: Error {
        case authorization(Authorization)
        case persistence(Persistence)
    }
}

// MARK: - HealthKitError.SaveObject Definition

@available(macOS 13.0, *)
extension HealthKitError {
    public enum Persistence: Error {
        case authorizationNotDetermined
        case authorizationDenied
        case frameworkFailedInternally
        case invalidArgument
        case unknownError(Error)
        case unknownFrameworkError(HKError)
    }
}

#endif
