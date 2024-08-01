//
//  BasicButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

struct BasicButtonFigureTheme: ButtonFigureTheme {
    private let size: BasicButtonSize
    private let _shape: BasicButtonShape
    
    init(size: BasicButtonSize, shape: BasicButtonShape) {
        self.size = size
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        switch size {
        case .large: .init(18, 32)
        case .medium: .init(12, 24)
        case .small: .init(10, 16)
        case .xsmall: .init(6, 8)
        }
    }
    
    func typo() -> Typo {
        switch size {
        case .large: .body0b
        case .medium: .body1b
        case .small, .xsmall: .body2
        }
    }
    
    func textSize() -> CGFloat {
        switch size {
        case .large: 18
        case .medium: 16
        case .small, .xsmall: 12
        }
    }
    
    func textWeight() -> Font.Weight {
        switch size {
        case .large: .semibold
        case .medium: .medium
        case .small, .xsmall: .regular
        }
    }
    
    func rounded() -> RoundedOffset {
        if _shape == .square {
            return .extraSmall
        }
        
        if _shape == .pill {
            return .init(all: .infinity)
        }
        
        switch size {
        case .large: return .large
        case .medium: return .medium
        case .small: return .medium
        case .xsmall: return .xsmall
        }
    }
    func borderWidth() -> CGFloat {
        return 1
    }
    
    func frame() -> FrameOffset {
        switch size {
        case .large, .medium: .init(.infinity, nil)
        case .small, .xsmall: .init(nil, nil)
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .square, .round:
            let offset = rounded()
            return IndividualRoundedRectangle(
                topLeftRadius: offset.topLeftRadius,
                topRightRadius: offset.topRightRadius,
                bottomLeftRadius: offset.bottomLeftRadius,
                bottomRightRadius: offset.bottomRightRadius
            ).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
}
