//
//  Member.swift
//  UserDefaultsUtility
//
//  Created by DOYEON LEE on 8/17/24.
//

import Foundation

public struct Member: UserDefaultsable {
    public static var key: String {
        String(describing: Member.self)
    }
    
    public let id: Int64
    public let name: String
    public let provider: String
    
    public init(
        id: Int64,
        name: String,
        provider: String
    ) {
        self.id = id
        self.name = name
        self.provider = provider
    }
}
