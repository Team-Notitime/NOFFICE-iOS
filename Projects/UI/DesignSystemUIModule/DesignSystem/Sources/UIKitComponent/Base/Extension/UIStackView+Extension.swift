//
//  UIStackView+Extension.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
