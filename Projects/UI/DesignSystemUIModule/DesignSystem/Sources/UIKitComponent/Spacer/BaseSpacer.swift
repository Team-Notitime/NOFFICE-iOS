//
//  DSSapcer.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import UIKit

public final class BaseSpacer: UIView {
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    public init(
        size: CGFloat,
        orientation: Orientation = .vertical
    ) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        self.snp.makeConstraints { make in
            switch orientation {
            case .vertical:
                make.height.equalTo(size)
            case .horizontal:
                make.width.equalTo(size)
            }
        }
    }
    
    /**
     When used with the StackView’s distribution = .fill property, it occupies an appropriate amount of space.
     */
    public init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
