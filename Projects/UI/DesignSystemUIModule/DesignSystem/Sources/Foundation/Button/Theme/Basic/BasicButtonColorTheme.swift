//
//  GrayButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import Foundation

import Assets

struct BasicButtonColorTheme: ButtonColorTheme {
    private let variant: BasicButtonVariant
    private let color: BasicButtonColor
    
    init(variant: BasicButtonVariant, color: BasicButtonColor) {
        self.variant = variant
        self.color = color
    }
    
    func backgroundColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill:
            return fillBackgroundColor(color: color, state: state)
        case .translucent:
            return translucentBackgroundColor(color: color, state: state)
        case .transparent:
            return state == .pressed ? .init(.grey100.opacity(0.5)) : .init(.none)
        }
    }
    
    func foregroundColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill:
            return fillForegroundColor(color: color, state: state)
        case .translucent:
            return translucentForegroundColor(color: color, state: state)
        case .transparent:
            return transparentForegroundColor(color: color, state: state)
        }
    }
    
    func borderColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill, .transparent, .translucent:
            return .init(.none)
        }
    }
}

private extension BasicButtonColorTheme {
    func fillBackgroundColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.green500)
        case (.green, .pressed): return .init(.green600)
        case (.ghost, .pressed): return .init(.grey100)
        case (.ghost, .enabled): return .init(.grey100)
        case (_, .disabled): return .init(.grey100)
        }
    }
    
    func translucentBackgroundColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.green100)
        case (.green, .pressed): return .init(.green200.opacity(0.5))
        case (.ghost, .pressed): return .init(.grey100.opacity(0.06))
        case (.ghost, .enabled): return .init(.grey100.opacity(0.06))
        case (_, .disabled): return .init(.grey100.opacity(0.06))
        }
    }
    
    func fillForegroundColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.fullWhite)
        case (.green, .pressed): return .init(.fullWhite)
        case (.ghost, .pressed): return .init(.grey500)
        case (.ghost, .enabled): return .init(.grey500)
        case (_, .disabled): return .init(.grey500)
        }
    }
    
    func translucentForegroundColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.green700)
        case (.green, .pressed): return .init(.green800)
        case (.ghost, .pressed): return .init(.grey500)
        case (.ghost, .enabled): return .init(.grey500)
        case (_, .disabled): return .init(.grey500)
        }
    }
    
    func transparentForegroundColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.green500)
        case (.green, .pressed): return .init(.green600)
        case (.ghost, .pressed): return .init(.grey500)
        case (.ghost, .enabled): return .init(.grey500)
        case (_, .disabled): return .init(.grey500)
        }
    }
    
    func transparentBorderColor(
        color: BasicButtonColor,
        state: ButtonState
    ) -> UniversalColor {
        switch (color, state) {
        case (.green, .enabled): return .init(.green500)
        case (.green, .pressed): return .init(.green600)
        case (.ghost, .pressed): return .init(.grey200)
        case (.ghost, .enabled): return .init(.grey200)
        case (_, .disabled): return .init(.grey200)
        }
    }
}
