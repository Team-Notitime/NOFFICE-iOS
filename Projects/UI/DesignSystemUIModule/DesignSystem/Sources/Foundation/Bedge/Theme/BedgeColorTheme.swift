//
//  BadgeColorTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

protocol BadgeColorTheme {
    func foregroundColor() -> UniversalColor
    func backgroundColor() -> UniversalColor
    func iconForegroundColor() -> UniversalColor
}
