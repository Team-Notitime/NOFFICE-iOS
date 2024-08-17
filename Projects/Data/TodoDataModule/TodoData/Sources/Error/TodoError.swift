//
//  TodoError.swift
//  TodoData
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation

/// An error type that todo related errors.
public enum TodoError: LocalizedError {
    /// The response from the server is not match client scheme.
    case invalidResponse
    
    /// Wraps another error that caused this error.
    case underlying(_ error: Error)
}
