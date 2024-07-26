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
    
    // - Funnel header
    lazy var funnelHeader = NofficeFunnelHeader(
        descriptionBuilder: {
            [
                UILabel().then {
                    $0.text = "선택 사항"
                    $0.setTypo(.body2b)
                    $0.textColor = .grey400
                }
            ]
        }
    ).then {
        $0.funnelType = .newGroup
        $0.title = "프로모션 코드를 입력해주세요"
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
        
        contentView.addSubview(funnelHeader)
        
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
        
        funnelHeader.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        promotionTextField.snp.makeConstraints {
            $0.top.equalTo(funnelHeader.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
