//
//  Keychainable.swift
//  KeychainUtility
//
//  Created by DOYEON LEE on 8/15/24.
//

public protocol Keychainable: Codable {
    static var identifier: String { get }
}
