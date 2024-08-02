//
//  BasicTextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import Assets

struct BasicTextFieldColorTheme: TextFieldColorTheme {
    let variant: BasicTextFieldVariant
    let color: BasicTextFieldColor
    
    func foregroundColor(state: TextFieldAllState) -> UniversalColor {
        switch state {
        case .disabled:
            return .init(.grey500)
        case .normal:
            return .init(.grey800)
        case .focused:
            return focusForegroundColor(color: color)
        default:
            return .init(.grey800)
        }
    }
    
    func placeholderColor(state: TextFieldAllState) -> UniversalColor {
        return .init(.grey400)
    }
    
    func backgroundColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .plain:
            return plainBackgroundColor(color: color, state: state)
        default:
            return .init(.none)
        }
    }
    
    func borderColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .outlined:
            return borderColorWithLineVariant(color: color, state: state)
        default:
            return .init(.none)
        }
    }
    
    func bottomBorderColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .underlined:
            return borderColorWithLineVariant(color: color, state: state)
        default:
            return .init(.none)
        }
    }
    
    func descriptionColor(state: TextFieldAllState) -> UniversalColor {
        switch state {
        case .error: return .init(.red500)
        case .success: return .init(.green600)
        default: return .init(.grey400)
        }
    }
}

extension BasicTextFieldColorTheme {
    func focusForegroundColor(
        color: BasicTextFieldColor
    ) -> UniversalColor {
        switch color {
        case .gray:
            return .init(.grey800)
        case .blue:
            return .init(.blue600)
        }
    }
    
    func plainBackgroundColor(
        color: BasicTextFieldColor,
        state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.gray, .normal): return .init(.grey100)
        case (.gray, .focused): return .init(.grey100)
        case (.blue, .normal): return .init(.blue100)
        case (.blue, .focused): return .init(.blue100)
        case (_, .disabled): return .init(.grey50)
        case (_, .error): return .init(.red500.opacity(0.1))
        case (_, .success): return .init(.green500.opacity(0.1))
        }
    }
    
    private func borderColorWithLineVariant(
        color: BasicTextFieldColor,
        state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.gray, .normal): return .init(.grey100)
        case (.gray, .focused): return .init(.grey200)
        case (.blue, .normal): return .init(.blue100)
        case (.blue, .focused): return .init(.blue200)
        case (_, .disabled): return .init(.grey100)
        case (_, .error): return .init(.red500)
        case (_, .success): return .init(.green500)
        }
    }
}
