//
//  CalendarCellColorTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

protocol CalendarCellColorTheme {
    func backgroundColor(state: CalendarCellState) -> UniversalColor
    func foregroundColor(state: CalendarCellState) -> UniversalColor
    func borderColor(state: CalendarCellState) -> UniversalColor
}
