//
//  BaseVStack.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

public class BaseVStack: UIStackView {
    public convenience init(
        spacing: CGFloat = 8,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        contentBuilder: () -> [UIView]
    ) {
        self.init()
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        contentBuilder().forEach { self.addArrangedSubview($0) }
    }
}
