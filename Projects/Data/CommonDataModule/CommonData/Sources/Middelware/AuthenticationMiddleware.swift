//
//  AuthenticationMiddleware.swift
//  CommonData
//
//  Created by DOYEON LEE on 8/15/24.
//

import KeychainUtility

import OpenAPIRuntime
import Foundation
import HTTPTypes

/// A client middleware that injects a value into the `Authorization` header field of the request.
public struct AuthenticationMiddleware: ClientMiddleware {
    public init() { }
    
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        // Adds the `Authorization` header field with the provided value.
        if let token = KeychainManager<Token>().get() {
            request.headerFields[.authorization] = token.accessToken
        } else {
            throw AuthenticationError.tokenNotFoundInKeychain
        }
        
        
        return try await next(request, body, baseURL)
    }
}

public enum AuthenticationError: LocalizedError {
    case tokenNotFoundInKeychain
}
