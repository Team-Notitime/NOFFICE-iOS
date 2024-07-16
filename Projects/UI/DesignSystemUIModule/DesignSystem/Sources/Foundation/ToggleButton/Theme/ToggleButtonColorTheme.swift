//
//  ToggleButtonTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ToggleButtonColorTheme {
    func indicatorForegroundColor(state: ToggleButtonState) -> UniversalColor
    func indicatorBackgroundColor(state: ToggleButtonState) -> UniversalColor
    func indicatorBorderColor(state: ToggleButtonState) -> UniversalColor
    func labelForegroundColor(state: ToggleButtonState) -> UniversalColor
}
