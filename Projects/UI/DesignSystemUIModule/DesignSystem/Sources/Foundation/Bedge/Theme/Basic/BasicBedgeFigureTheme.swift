//
//  BasicBedgeFigureTheme.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

public struct BasicBedgeFigureTheme: BedgeFigureTheme {
    func padding() -> GapOffset {
        return .init(4, 12)
    }
    
    func rounded() -> RoundedOffset {
        return .init(all: 10)
    }
}
