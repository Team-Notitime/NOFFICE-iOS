//
//  NofficeFunnelHeader.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

public final class NofficeFunnelHeader: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: State
    public var funnelType: FunnelType = .none {
        didSet {
            updateSubTitle()
        }
    }
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: UI Component
    // - Container stack
    lazy var stackView = BaseVStack {
        [
            subTitleStack,
            titleLabel,
            descriptionStack
        ]
    }
    
    // - Sub title
    lazy var subTitleStack = BaseHStack {
        [
            subTitleIcon,
            subTitleLabel
        ]
    }
    
    lazy var subTitleIcon = UIImageView(image: .iconGrid).then {
        $0.tintColor = .green500
        $0.setSize(width: 18, height: 18)
    }
    
    lazy var subTitleLabel =  UILabel().then {
        $0.textColor = .green500
        $0.setTypo(.body1b)
    }
    
    // - Title
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .grey800
        $0.setTypo(.heading3)
        $0.numberOfLines = 0
    }
    
    // - Description
    private lazy var descriptionStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    // MARK: Build component
    private var descriptionComponents: [UIView] = []
    
    // MARK: Initializer
    public init(
        descriptionBuilder: ViewBuilder = { [] }
    ) {
        super.init(frame: .zero)
        
        descriptionComponents = descriptionBuilder()
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateSubTitle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateSubTitle()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(stackView)
        
        if descriptionComponents.isEmpty {
            descriptionStack.isHidden = true
        } else {
            descriptionComponents.forEach {
                descriptionStack.addArrangedSubview($0)
            }
        }
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
                .inset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
            $0.bottom.equalToSuperview()
                .inset(FunnelConstant.spacingUnit * 2)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateSubTitle() {
        switch funnelType {
        case .none:
            subTitleStack.isHidden = true
        case .newGroup:
            subTitleStack.isHidden = false
            subTitleIcon.image = .iconGrid
            subTitleLabel.text = "그룹 만들기"
        case .newAnnouncement:
            subTitleStack.isHidden = true
        }
    }
}

// MARK: - DisplayModel
public extension NofficeFunnelHeader {
    enum FunnelType {
        case none
        case newGroup
        case newAnnouncement
    }
}
