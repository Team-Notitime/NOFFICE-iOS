//
//  AuthenticationMiddleware.swift
//  CommonData
//
//  Created by DOYEON LEE on 8/15/24.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes

/// A client middleware that injects a value into the `Authorization` header field of the request.
public struct AuthenticationMiddleware {
    
    /// The value for the `Authorization` header field.
    private let token: String
    
    /// Creates a new middleware.
    /// - Parameter token: The value for the `Authorization` header field.
    public init(
        token: String
    ) {
        self.token = token
    }
}

extension AuthenticationMiddleware: ClientMiddleware {
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        // Adds the `Authorization` header field with the provided value.
        request.headerFields[.authorization] = token
        return try await next(request, body, baseURL)
    }
}
