//
//  BasicToggleButtonTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import Assets

struct BasicToggleButtonColorTheme: ToggleButtonColorTheme {
    let color: BasicToggleButtonColor
    
    func indicatorBackgroundColor(state: ToggleButtonState) -> UniversalColor {
        switch (state, color) {
        case (.unchecked, _): return .init(.grey100)
        case (.checked, .green): return .init(.green500)
        }
    }
    
    func indicatorForegroundColor(state: ToggleButtonState) -> UniversalColor {
        switch (state, color) {
        case (.unchecked, _): return .init(.grey300)
        case (.checked, _): return .init(.white)
        }
    }
    
    func indicatorBorderColor(state: ToggleButtonState) -> UniversalColor {
        return .init(.none)
    }
    
    func labelForegroundColor(state: ToggleButtonState) -> UniversalColor {
        return .init(.grey800)
    }
}
