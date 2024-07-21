//
//  Collection+Extension.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/21/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
