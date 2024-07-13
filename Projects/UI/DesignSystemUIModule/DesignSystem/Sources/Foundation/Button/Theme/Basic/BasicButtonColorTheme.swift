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
            return fillBackgroundColor(state: state, color: color)
        case .translucent:
            return translucentBackgroundColor(state: state, color: color)
        case .transparent:
            return state == .pressed ? .init(.grey100.opacity(0.5)) : .init(.none)
        }
    }
    
    func foregroundColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill:
            return .init(.white)
        case .translucent:
            return translucentForegroundColor(state: state, color: color)
        case .transparent:
            return transparentForegroundColor(state: state, color: color)
        }
    }
    
    func borderColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill, .translucent:
            return .init(.none)
        case .transparent:
            return .init(.none)
        }
    }
}

private extension BasicButtonColorTheme {
    func fillBackgroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> UniversalColor {
        switch (state, color) {
        case (.enabled, .green): return .init(.green500)
        case (.pressed, .green): return .init(.green600)
        case (.disabled, _): return .init(.grey100)
        }
    }
    
    func translucentBackgroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> UniversalColor {
        switch (state, color) {
        case (.enabled, .green): return .init(.green500.opacity(0.06))
        case (.pressed, .green): return .init(.green600.opacity(0.06))
        case (.disabled, _): return .init(.grey100)
        }
    }
    
    func translucentForegroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> UniversalColor {
        switch (state, color) {
        case (.enabled, .green): return .init(.green500)
        case (.pressed, .green): return .init(.green600)
        case (.disabled, _): return .init(.grey500)
        }
    }
    
    func transparentForegroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> UniversalColor {
        switch (state, color) {
        case (.enabled, .green): return .init(.green500)
        case (.pressed, .green): return .init(.green600)
        case (.disabled, _): return .init(.grey500)
        }
    }
}
