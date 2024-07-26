//
//  NewAnnouncementCompleteView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/25/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class CompletePageView: BaseView {
    // MARK: UI Constant
    private let groupImageSize: CGFloat = 140
    
    // MARK: UI Component
    // - Group image
    lazy var completeImageView: UIImageView = UIImageView(image: .imgNottiBell).then {
        $0.setSize(width: groupImageSize, height: groupImageSize)
        $0.contentMode = .scaleAspectFit
    }
    
    // - Text section
    lazy var titleLabel = UILabel().then {
        $0.text = "노티가 등록되었어요"
        $0.setTypo(.heading4)
        $0.textColor = .grey800
    }

    lazy var subTitleLabel = UILabel().then {
        $0.text = "등록된 노티를 확인하러 갈까요?"
        $0.setTypo(.body2)
        $0.textColor = .grey600
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
                    $0.text = "확인하러 가기"
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
        addSubview(completeImageView)
        
        addSubview(titleLabel)
        
        addSubview(subTitleLabel)
        
        addSubview(buttonStack)
    }
    
    override func setupLayout() {
        completeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
                .offset(-groupImageSize * 0.8)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(completeImageView.snp.bottom)
                .offset(24)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(8)
            $0.centerX.equalToSuperview()
        }

        buttonStack.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalTo(safeAreaLayoutGuide)
                .inset(FunnelConstant.spacingUnit * 2)
        }
    }
}
