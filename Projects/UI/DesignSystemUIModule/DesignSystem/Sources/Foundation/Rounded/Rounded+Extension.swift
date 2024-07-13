//
//  Rounded+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import Foundation

extension RoundedOffset {
    /// 0
    static let zero = RoundedOffset()
    /// 2
    static let extraSmall = RoundedOffset(all: 2)
    /// 2
    static let xsmall = RoundedOffset(all: 2)
    /// 4
    static let small = RoundedOffset(all: 4)
    /// 8
    static let medium = RoundedOffset(all: 8)
    /// 12
    static let large = RoundedOffset(all: 12)
    /// 16
    static let xlarge = RoundedOffset(all: 16)
    /// infinity
    static let infinity = RoundedOffset(all: .infinity)
}
