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
            return .init(.grey400)
        case .normal:
            return .init(.grey800)
        case .focused:
            return .init(.grey800)
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
        return .init(.grey400)
    }
}

extension BasicTextFieldColorTheme {
    func plainBackgroundColor(
        color: BasicTextFieldColor,
        state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.gray, .normal): return .init(.grey100)
        case (.gray, .focused): return .init(.grey100)
        case (.gray, .disabled): return .init(.grey50)
        case (.gray, .error): return .init(.grey100) // TODO
        case (.gray, .success): return .init(.grey100) // TODO
        }
    }
    
    private func borderColorWithLineVariant(
        color: BasicTextFieldColor,
        state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.gray, .normal): return .init(.grey100)
        case (.gray, .focused): return .init(.grey200)
        case (.gray, .disabled): return .init(.grey100)
        case (.gray, .error): return .init(.grey100) // TODO
        case (.gray, .success): return .init(.grey100) // TODO
        }
    }
}
