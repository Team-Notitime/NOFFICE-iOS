//
//  NewOrganizationPromotionPageView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class NewOrganizationPromotionPageView: BaseView {
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Funnel title
    lazy var pageSubTitle = BaseHStack {
        [
            UIImageView(image: .iconGrid).then {
                $0.tintColor = .green500
                $0.setSize(width: 18, height: 18)
            },
            UILabel().then {
                $0.text = "그룹 만들기"
                $0.textColor = .green500
                $0.setTypo(.body1b)
            }
        ]
    }
    
    // - Page title
    lazy var pageTitleLabel = UILabel().then {
        $0.text = "프로모션 코드를 입력해주세요"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Textfield
    lazy var promotionTextField = BaseTextField().then {
        $0.placeholder = "코드를 입력해주세요"
        $0.styled(variant: .outlined, shape: .round)
    }
    
    // - Complete button
    lazy var completeButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "다음"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green)
        $0.isEnabled = false
    }
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(pageSubTitle)
        
        contentView.addSubview(pageTitleLabel)
        
        contentView.addSubview(promotionTextField)
        
        contentView.addSubview(completeButton)
    }
    
    override func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        pageSubTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pageSubTitle.snp.bottom)
                .offset(FunnelConstant.spacingUnit / 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        promotionTextField.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
