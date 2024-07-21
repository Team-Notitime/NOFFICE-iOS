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
        size: CGFloat = 0,
        orientation: Orientation = .vertical
    ) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        self.snp.makeConstraints { make in
            switch orientation {
            case .vertical:
                make.height.lessThanOrEqualTo(size)
            case .horizontal:
                make.width.lessThanOrEqualTo(size)
            }
        }
    }
    
    /**
     When used with the StackView’s distribution = .fill property, it occupies an appropriate amount of space.
     
     - Important: A spacer occupies the maximum size only when there is a single spacer in the stack view. 
     If there are two or more spacers, you need to specify their sizes directly using init(size:orientation:).
     */
    public init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
