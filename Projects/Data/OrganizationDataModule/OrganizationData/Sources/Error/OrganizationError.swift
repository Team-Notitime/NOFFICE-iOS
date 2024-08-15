//
//  OrganizationError.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

/// An error type that organization related errors.
public enum OrganizationError: LocalizedError {
    /// The response from the server is not match client scheme.
    case invalidResponse
    
    /// Wraps another error that caused this error.
    case underlying(_ error: Error)
}
