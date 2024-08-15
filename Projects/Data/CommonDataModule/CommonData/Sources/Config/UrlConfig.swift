//
//  UrlConfig.swift
//  MemberData
//
//  Created by DOYEON LEE on 8/12/24.
//

import Foundation

public enum UrlConfig {
    case baseUrl
    
    public var get: String {
        switch self {
        case .baseUrl:
            guard let url = Bundle.module.object(forInfoDictionaryKey: "API_BASE_URL") as? String
            else { fatalError("API_BASE_URL is not set in Info.plist") }
            return url
        }
    }
    
    public var url: URL {
        switch self {
        case .baseUrl:
            guard let url = URL(string: self.get) else {
                fatalError("Invalid URL string for API_BASE_URL")
            }
            return url
        }
    }
}
