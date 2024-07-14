//
//  BaseVStack.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

public class BaseVStack: UIStackView {
    public convenience init(
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 8,
        contentBuilder: () -> [UIView]
    ) {
        self.init()
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        
        contentBuilder().forEach { self.addArrangedSubview($0) }
    }
    
    public convenience init(
        contents: [UIView],
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 8
    ) {
        self.init()
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        
        contents.forEach { self.addArrangedSubview($0) }
    }
}
