//
//  DSSapcer.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import UIKit

import SnapKit

public final class BaseSpacer: UIView {
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    public init(
        size: CGFloat = 0,
        orientation: Orientation = .vertical,
        fixedSize: Bool = false
    ) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        self.snp.makeConstraints { make in
            switch orientation {
            case .vertical:
                if fixedSize {
                    make.height.equalTo(size)
                } else {
                    make.height.lessThanOrEqualTo(size)
                }
            case .horizontal:
                if fixedSize {
                    make.width.equalTo(size)
                } else {
                    make.width.lessThanOrEqualTo(size)
                }
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
