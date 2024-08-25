//
//  ImageError.swift
//  ImageData
//
//  Created by DOYEON LEE on 8/25/24.
//

import Foundation

/// An error type that announcement related errors.
public enum ImageError: LocalizedError {
    /// The response from the server is not match client scheme.
    case invalidResponse
    
    /// Wraps another error that caused this error.
    case underlying(_ error: Error)
}
