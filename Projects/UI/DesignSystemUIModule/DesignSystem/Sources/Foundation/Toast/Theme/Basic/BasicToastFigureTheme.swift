//
//  BasicToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

struct BasicToastFigureTheme: ToastFigureTheme {
    private let variant: BasicToastVariant
    private let _shape: BasicToastShape
    
    init(
        variant: BasicToastVariant,
        shape: BasicToastShape
    ) {
        self.variant = variant
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        return .init(12, 16)
    }
    
    func rounded() -> RoundedOffset {
        switch _shape {
        case .round: return .large
        case .square: return .xsmall
        case .pill: return .infinity
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .square:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
    
    func imageName() -> ImageName? {
        switch variant {
        case .success: return .system("checkmark.circle")
        case .warning: return .system("exclamationmark.triangle")
        case .error: return .system("exclamationmark.circle.fill")
        case .info: return nil
        }
    }
    
    func imageSize() -> FrameOffset {
        return .init(20, 20)
    }
    
    func messageTypo() -> Typo {
        return .body2b
    }
}
