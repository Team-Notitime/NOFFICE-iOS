//
//  Token.swift
//  KeychainUtility
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation

public struct Token: Keychainable, Codable {
    public static var identifier: String {
        String(describing: self)
    }
    
    public let accessToken: String
    public let refreshToken: String
    
    public init(
        accessToken: String,
        refreshToken: String
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
