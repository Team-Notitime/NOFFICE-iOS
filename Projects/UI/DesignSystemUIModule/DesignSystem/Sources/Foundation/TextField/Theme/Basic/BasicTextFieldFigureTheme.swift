//
//  BasicTextFieldFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct BasicTextFieldFigureTheme: TextFieldFigureTheme {
    private let variant: BasicTextFieldVariant
    private let size: BasicTextFieldSize
    private let _shape: BasicTextFieldShape
    
    init(
        variant: BasicTextFieldVariant,
        size: BasicTextFieldSize,
        shape: BasicTextFieldShape
    ) {
        self.variant = variant
        self.size = size
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        if variant == .underlined {
            switch size {
            case .textLarge, .large: return .init(16, 0)
            case .medium: return .init(10, 0)
            case .small: return .init(8, 0)
            }
        }
        
        switch size {
        case .textLarge, .large: return .init(16, 20)
        case .medium: return .init(10, 20)
        case .small: return .init(8, 16)
        }
    }
    
    func typo() -> Typo {
        switch size {
        case .textLarge: .heading3
        case .large: .body1
        case .medium: .body1
        case .small: .body2
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
        case .textLarge, .large: return .large
        case .medium: return .medium
        case .small: return .small
        }
    }
    
    func borderWidth() -> CGFloat {
        return 1
    }
    
    func frame() -> FrameOffset {
        return .init(.infinity, nil)
    }
    
    func shape() -> AnyShape {
        let offset = rounded()
        switch _shape {
        case .square, .round:
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
