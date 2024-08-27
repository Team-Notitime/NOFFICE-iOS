//
//  TokenRefreshingMiddleware.swift
//  CommonData
//
//  Created by DOYEON LEE on 8/28/24.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes

import NotificationCenterUtility

/// A middleware that refreshes the token when a 401 Unauthorized error is encountered.
public struct TokenRefreshingMiddleware: ClientMiddleware {
    public init() { }
    
    /// Function to intercept requests and handle 401 Unauthorized responses.
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        do {
            let (response, responseBody) = try await next(request, body, baseURL)
            
            if response.status.code == 401 {
                print("401 Unauthorized received, refreshing token")
                do {
                    try await refreshToken(baseURL: baseURL)
                    return try await next(request, body, baseURL)
                } catch {
                    NotificationCenter.default.post(name: .tokenExpired, object: nil)
                    throw error
                }
            }
            
            return (response, responseBody)
        } catch {
            throw error
        }
    }
    
    /// Function to refresh the token.
    /// - Parameter baseURL: The base URL for the API requests.
    /// - Throws: An error if the token refresh fails.
    private func refreshToken(baseURL: URL) async throws {
        // Construct the URL for the token refresh endpoint.
        let refreshTokenURL = baseURL.appendingPathComponent("/api/v1/member/reissue")
        
        // Create the request for token refresh.
        var request = URLRequest(url: refreshTokenURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(retrieveRefreshToken())", forHTTPHeaderField: "Authorization")
        
        // Send the request to refresh the token.
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response status code is 200.
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(
                domain: "TokenRefreshingMiddleware",
                code: -100, // FIXME: Replace this with the actual error
                userInfo: [NSLocalizedDescriptionKey: "Token refresh failed"]
            )
        }
        
        // Decode the response to extract the new tokens.
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(
            TokenRefreshResponse.self,
            from: data
        )
        
        // Update the stored tokens.
        storeNewTokens(
            accessToken: responseBody.data.accessToken,
            refreshToken: responseBody.data.refreshToken
        )
    }
    
    /// Function to retrieve the stored refresh token.
    /// - Returns: The stored refresh token as a string.
    private func retrieveRefreshToken() -> String {
        // Replace this with the actual implementation to retrieve the refresh token.
        return "yourStoredRefreshToken"
    }
    
    /// Function to store the new access and refresh tokens.
    /// - Parameters:
    ///   - accessToken: The new access token.
    ///   - refreshToken: The new refresh token.
    private func storeNewTokens(accessToken: String, refreshToken: String) {
        // Replace this with the actual implementation to store the new tokens.
        print("Storing new tokens: AccessToken - \(accessToken), RefreshToken - \(refreshToken)")
    }
}

/// The structure representing the response from the token refresh endpoint.
struct TokenRefreshResponse: Codable {
    struct TokenData: Codable {
        let accessToken: String
        let refreshToken: String
    }
    let data: TokenData
}

// Define a notification name for token expiration.
extension Notification.Name {
    static let tokenExpired = Notification.Name("tokenExpiredNotification")
}
