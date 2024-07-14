//
//  BasicCardFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

struct BasicCardFigureTheme: CardFigureTheme {
    private let _shape: BasicCardShape
    private let _padding: BasicCardPadding
    
    init(
        shape: BasicCardShape,
        padding: BasicCardPadding
    ) {
        self._shape = shape
        self._padding = padding
    }
    
    func padding() -> GapOffset {
        switch _padding {
        case .none: return .init(all: .zero)
        case .large: return .init(22, 24)
        case .medium: return .init(18, 20)
        case .small: return .init(14, 16)
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round, .square:
            let offset = rounded()
            return IndividualRoundedRectangle(
                topLeftRadius: offset.topLeftRadius,
                topRightRadius: offset.topRightRadius,
                bottomLeftRadius: offset.bottomLeftRadius,
                bottomRightRadius: offset.bottomRightRadius
            ).asAnyShape()
        }
    }
    
    func rounded() -> RoundedOffset {
        switch _shape {
        case .round: return .xlarge
        case .square: return .small
        }
    }
}
