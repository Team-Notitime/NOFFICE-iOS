//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicToastColorTheme: ToastColorTheme {
    private let variant: BasicToastVariant
    
    init(variant: BasicToastVariant) {
        self.variant = variant
    }
    
    func backgroundColor() -> UniversalColor {
        switch variant {
        case .success: return .init(.green100)
        case .warning: return .init(.yellow100)
        case .error: return .init(.red500.opacity(0.2))
        case .info: return .init(.grey100)
        }
    }
    
    func foregroundColor() -> UniversalColor {
        switch variant {
        case .success: return .init(.green600)
        case .warning: return .init(.yellow600)
        case .error: return .init(.red500)
        case .info: return .init(.grey600)
        }
    }
}
