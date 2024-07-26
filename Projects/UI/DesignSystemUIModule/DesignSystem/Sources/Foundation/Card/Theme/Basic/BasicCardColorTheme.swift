//
//  BasicCardColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Assets

struct BasicCardColorTheme: CardColorTheme {
    private let variant: BasicCardVariant
    private let color: BasicCardColor
    
    init(
        variant: BasicCardVariant,
        color: BasicCardColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func backgroundColor() -> UniversalColor {
        switch(variant, color) {
        case (.outline, _): return .init(.none)
        case (.translucent, .green): return .init(.green100)
        case (.translucent, .blue): return .init(.blue100)
        case (.translucent, .yellow): return .init(.yellow100)
        case (.translucent, .gray): return .init(.grey100)
        case (.translucent, .background): return .init(.fullWhite)
        }
    }
    
    func borderColor() -> UniversalColor {
        switch(variant, color) {
        case (.outline, .green): return .init(.green500.opacity(0.5))
        case (.outline, .blue): return .init(.blue500.opacity(0.5))
        case (.outline, .yellow): return .init(.yellow500.opacity(0.5))
        case (.outline, .gray): return .init(.grey200)
        case (.outline, .background): return .init(.grey200)
        case (.translucent, _): return .init(.none)
        }
    }
}
