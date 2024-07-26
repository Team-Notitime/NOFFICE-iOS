//
//  NewOrganizationCompletePageView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import SnapKit
import Then

class NewOrganizationCompletePageView: BaseView {
    // MARK: UI Constant
    private let groupImageSize: CGFloat = 120
    
    // MARK: UI Component
    // - Group image
    lazy var groupImageView: UIImageView = UIImageView(image: .imgProfileGroup).then {
        $0.backgroundColor = .grey200
        $0.layer.cornerRadius = groupImageSize / 2
        $0.setSize(width: groupImageSize, height: groupImageSize)
    }
    
    // - Text section
    lazy var titleLabel = UILabel().then {
        $0.text = "그룹을 만들었어요!"
        $0.setTypo(.heading4)
        $0.textColor = .grey800
    }

    lazy var subTitleLabel = UILabel().then {
        $0.text = "링크를 통해 멤버들을 초대해보세요."
        $0.setTypo(.body2)
        $0.textColor = .grey600
    }
    
    // - Link
    lazy var linkTextField = BaseTextField().then {
        $0.styled(variant: .outlined, shape: .round)
        $0.disabled = true
    }
    
    // - Buttons
    lazy var goHomeButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "홈으로"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .ghost, shape: .round)
    }
    
    lazy var copyLinkButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "초대 링크 복사"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green, shape: .round)
    }
    
    lazy var buttonStack = BaseHStack(distribution: .fillEqually) {
        [
            goHomeButton,
            copyLinkButton
        ]
    }

    // MARK: Setup
    override func setupHierarchy() {
        addSubview(groupImageView)
        
        addSubview(titleLabel)
        
        addSubview(subTitleLabel)
        
        addSubview(linkTextField)
        
        addSubview(buttonStack)
    }
    
    override func setupLayout() {
        groupImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
                .offset(-groupImageSize * 0.8)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom)
                .offset(24)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(8)
            $0.centerX.equalToSuperview()
        }
        
        linkTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom)
                .offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        
        buttonStack.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalTo(safeAreaLayoutGuide)
                .inset(FunnelConstant.spacingUnit * 2)
        }
    }
}
