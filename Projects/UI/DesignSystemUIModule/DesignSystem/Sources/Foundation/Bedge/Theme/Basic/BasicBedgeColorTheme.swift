//
//  BasicBadgeColorTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

import Assets

public struct BasicBadgeColorTheme: BadgeColorTheme {
    private var color: BasicBadgeColor
    private var variant: BasicBadgeVariant
    
    init(
        color: BasicBadgeColor,
        variant: BasicBadgeVariant
    ) {
        self.color = color
        self.variant = variant
    }
    
    func foregroundColor() -> UniversalColor {
        switch (color, variant) {
        case (.green, .on): return .init(.fullWhite)
        case (.green, .weak): return .init(.green800)
        case (.green, .off): return .init(.grey500)
        }
    }
    
    func backgroundColor() -> UniversalColor {
        switch (color, variant) {
        case (.green, .on): return .init(.green500)
        case (.green, .weak): return .init(.green500.opacity(0.16))
        case (.green, .off): return .init(.grey100)
        }
    }
    
    func iconForegroundColor() -> UniversalColor {
        return .init(foregroundColor().color.opacity(0.5))
    }
}
