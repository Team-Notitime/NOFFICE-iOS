//
//  MemberError.swift
//  MemberData
//
//  Created by DOYEON LEE on 8/12/24.
//

import Foundation

/// An error type that member related errors.
public enum MemberError: LocalizedError {
    /// The response from the server is not match client scheme.
    case invalidResponse
    
    /// Wraps another error that caused this error.
    case underlying(Error)
}
