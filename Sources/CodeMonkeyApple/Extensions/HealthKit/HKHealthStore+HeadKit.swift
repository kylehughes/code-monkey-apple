//
//  HKHealthStore+Super Headache.swift
//  Super Headache
//
//  Created by Kyle Hughes on 3/21/21.
//

#if canImport(HealthKit)

import Combine
import HealthKit

@available(macOS 13.0, *)
extension HKHealthStore {
    // MARK: Public Instance Interface
    
    public func requestAuthorization(
        toReadObjectTypes typesToRead: Set<HKObjectType>
    ) async -> Result<Void, HealthKitError.Authorization> {
        await requestAuthorization(toShareSampleTypes: [], andReadObjectTypes: typesToRead)
    }

    public func requestAuthorization(
        toShareSample sample: HKSample
    ) async -> Result<Void, HealthKitError.Authorization> {
        await requestAuthorization(toShareSampleTypes: [sample.sampleType], andReadObjectTypes: [])
    }
    
    public func requestAuthorization(
        toShareSampleTypes typesToShare: Set<HKSampleType>
    ) async -> Result<Void, HealthKitError.Authorization> {
        await requestAuthorization(toShareSampleTypes: typesToShare, andReadObjectTypes: [])
    }
    
    public func requestAuthorization(
        toShareSampleTypes typesToShare: Set<HKSampleType>,
        andReadObjectTypes typesToRead: Set<HKObjectType>
    ) async -> Result<Void, HealthKitError.Authorization> {
        do {
            try await requestAuthorization(toShare: typesToShare, read: typesToRead)
            
            return .success
        } catch {
            guard let frameworkError = error as? HKError else {
                return .failure(HealthKitError.Authorization.unknownError(error))
            }
            
            let appError: HealthKitError.Authorization = {
                switch frameworkError.code {
                case .errorAuthorizationNotDetermined:
                    return .userIgnored
                default:
                    return .frameworkError(frameworkError)
                }
            }()
            
            return .failure(appError)
        }
    }
    
    public func saveWithResult(_ object: HKObject) async -> Result<Void, HealthKitError.Persistence> {
        do {
            try await save(object) as Void
            
            return .success
        } catch {
            guard let frameworkError = error as? HKError else {
                return .failure(.unknownError(error))
            }
            
            let appError: HealthKitError.Persistence = {
                switch frameworkError.code {
                case .errorAuthorizationNotDetermined:
                    return .authorizationNotDetermined
                case .errorAuthorizationDenied:
                    return .authorizationDenied
                case .errorInvalidArgument:
                    return .invalidArgument
                default:
                    return .unknownFrameworkError(frameworkError)
                }
            }()
            
            return .failure(appError)
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(macOS 13.0, *)
extension HKHealthStore {
    public static let preview = HKHealthStore()
}
#endif

#endif
