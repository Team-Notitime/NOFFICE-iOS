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
        case (.green, .weak): return .init(.green800)
        case (.blue, .weak): return .init(.blue800)
        case (.yellow, .weak): return .init(.yellow900)
        case (_, .on): return .init(.fullWhite)
        case (_, .off): return .init(.grey500)
        }
    }
    
    func backgroundColor() -> UniversalColor {
        switch (color, variant) {
        case (.green, .on): return .init(.green500)
        case (.green, .weak): return .init(.green500.opacity(0.16))
        case (.blue, .on): return .init(.blue500)
        case (.blue, .weak): return .init(.blue500.opacity(0.16))
        case (.yellow, .on): return .init(.yellow500)
        case (.yellow, .weak): return .init(.yellow500.opacity(0.16))
        case (_, .off): return .init(.grey100)
        }
    }
    
    func iconForegroundColor() -> UniversalColor {
        switch (color, variant) {
        case (.green, .weak): return .init(.green500)
        case (.blue, .weak): return .init(.blue500)
        case (.yellow, .weak): return .init(.yellow500)
        case (_, .on): return .init(.fullWhite)
        case (_, .off): return .init(.grey500)
        }
    }
}
