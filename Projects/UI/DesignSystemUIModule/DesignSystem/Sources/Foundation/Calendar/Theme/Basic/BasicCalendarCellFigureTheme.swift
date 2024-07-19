//
//  BasicCalendarCellFigureTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

struct BasicCalendarCellFigureTheme: CalendarCellFigureTheme {
    private let _shape: BasicCalendarCellShape
    
    init(
        shape: BasicCalendarCellShape
    ) {
        self._shape = shape
    }
    
    func rounded() -> RoundedOffset {
        switch _shape {
        case .round:
            return .medium
        case .square:
            return .small
        case .circle:
            return .infinity
        }
    }
}
