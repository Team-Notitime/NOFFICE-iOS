//
//  BasicBadgeFigureTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

public struct BasicBadgeFigureTheme: BadgeFigureTheme {
    func padding() -> GapOffset {
        return .init(6, 12)
    }
    
    func rounded() -> RoundedOffset {
        return .init(all: 10)
    }
}
