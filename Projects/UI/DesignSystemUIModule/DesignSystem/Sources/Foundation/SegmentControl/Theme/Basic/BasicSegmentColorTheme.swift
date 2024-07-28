//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

import Assets

struct BasicSegmentColorTheme: SegmentColorTheme {
    private let variant: BasicSegmentVariant
    private let color: BasicSegmentColor
    
    init(
        variant: BasicSegmentVariant,
        color: BasicSegmentColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func itemForegroundColor(state: SegmentState) -> UniversalColor {
        // for underline
        if variant == .underline {
            switch state {
            case .selected: return .init(.grey800)
            case .unselected: return .init(.grey600)
            }
        }
        
        // for flat, shadow
        switch (color, state) {
        case (.green, .unselected): return .init(.grey400)
        case (.green, .selected): return .init(.fullWhite)
        case (.stone, .unselected): return .init(.grey400)
        case (.stone, .selected): return .init(.fullWhite)
        }
    }
    
    func indicatorBackgroundColor() -> UniversalColor {
        switch (variant, color) {
        case (.underline, .green): return .init(.green500)
        case (.underline, .stone): return .init(.grey800)
        case (_, .green): return .init(.green500)
        case (_, .stone): return .init(.grey800)
        }
    }
    
    func indicatorShadow() -> UniversalColor {
        switch variant {
        case .flat: return .init(.clear)
        case .shadow: return .init(.black.opacity(0.2))
        case .underline: return .init(.clear)
        }
    }
    
    func containerBackgroundColor() -> UniversalColor {
        switch variant {
        case .flat, .shadow:
            return .init(.grey100)
        case .underline:
            return .init(.clear)
        }
    }
}
