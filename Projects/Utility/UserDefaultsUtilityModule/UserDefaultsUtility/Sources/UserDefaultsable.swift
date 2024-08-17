//
//  UserDefaultsable.swift
//  UserDefaultsUtility
//
//  Created by DOYEON LEE on 8/17/24.
//

import Foundation

public protocol UserDefaultsable: Codable {
    static var key: String { get }
}
