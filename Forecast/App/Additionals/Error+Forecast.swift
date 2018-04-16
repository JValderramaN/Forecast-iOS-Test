//
//  Error+Forecast.swift
//  Forecast
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import Foundation

public enum FError: Int, CustomNSError, LocalizedError {
    /// Could not get user's coordinate
    case couldNotGetUserCoordinate
    /// Could not process forecast data
    case couldNotProcessForecastData
    /// Location Service not allowed
    case locationServiceNotAllowed
    
    public var errorDescription: String? {
        switch self {
        case .couldNotGetUserCoordinate: return NSLocalizedString("Could not get user's coordinate", comment: "")
        case .couldNotProcessForecastData: return NSLocalizedString("Could not process Forecast data", comment: "")
        case .locationServiceNotAllowed: return NSLocalizedString("Please allow the location service for this app in order to work properly", comment: "")
        }
    }
    
    public var errorCode: Int {
        return self.rawValue
    }
    
    public static var errorDomain : String {
        return "Forecase iOS Test"
    }
}


public extension NSError {
    class public func errorFromForecastError(_ forecastError: FError) -> NSError? {
        return NSError(domain: FError.errorDomain, code: forecastError.errorCode, userInfo: [NSLocalizedDescriptionKey : forecastError.errorDescription ?? forecastError.localizedDescription])
    }
}
