//
//  BasicCalendarCellColorTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import Assets

struct BasicCalendarCellColorTheme: CalendarCellColorTheme {
    private let color: BasicCalendarCellColor
    private let type: CalendarCellType
    
    init(
        color: BasicCalendarCellColor,
        type: CalendarCellType
    ) {
        self.color = color
        self.type = type
    }
    
    func backgroundColor(state: CalendarCellState) -> UniversalColor {
        switch (color, state) {
        case (_, .normal): return .init(.none)
        case (_, .disabled): return .init(.none)
        case (.green, .selected): return .init(.green500)
        }
    }
    
    func foregroundColor(state: CalendarCellState) -> UniversalColor {
        switch state {
        case .selected: return .init(.fullWhite)
        case .disabled: return .init(.grey300)
        default: break
        }
        
        switch type {
        case .sun: return .init(.red500)
        default: return .init(.grey700)
        }
    }
    
    func borderColor(state: CalendarCellState) -> UniversalColor {
        return .init(.none)
    }
    
}
