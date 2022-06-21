//
//  SaveToHealthError.swift
//  Models
//
//  Created by Kyle Hughes on 3/24/21.
//

import HealthKit

public enum HealthKitError {
    // NO-OP
}

// MARK: - HealthKitError.Authorization Definition

extension HealthKitError {
    public enum Authorization: Error {
        case frameworkError(HKError)
        case frameworkFailedInternally
        case unknownError(Error)
        case userIgnored
    }
}

// MARK: - HealthKitError.Authorization Definition

extension HealthKitError {
    public enum AuthorizationAndPersistence: Error {
        case authorization(Authorization)
        case persistence(Persistence)
    }
}

// MARK: - HealthKitError.SaveObject Definition

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
