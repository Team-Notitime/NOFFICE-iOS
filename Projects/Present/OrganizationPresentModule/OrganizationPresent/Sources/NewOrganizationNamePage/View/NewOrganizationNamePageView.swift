//
//  NewOrganizationNameView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class NewOrganizationNamePageView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Funnel title
    lazy var pageSubTitle = BaseHStack {
        [
            UIImageView(image: .iconGroup).then {
                $0.tintColor = .green500
            },
            UILabel().then {
                $0.text = "그룹 만들기"
                $0.setTypo(.body1b)
                $0.textColor = .grey500
            }
        ]
    }
    
    // - Page title
    lazy var pageTitleLabel = UILabel().then {
        $0.text = "약관에 동의해주세요"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Textfield
    lazy var nameTextField = BaseTextField().then {
        $0.placeholder = "실명을 입력해주세요"
        $0.styled(variant: .outlined, shape: .round)
    }
    
    // - Complete button
    lazy var completeButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "완료"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green)
        $0.isEnabled = false
    }
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(contentView)
        
        contentView.addSubview(pageTitleLabel)
        
        contentView.addSubview(nameTextField)
        
        contentView.addSubview(completeButton)
    }
    
    public override func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 4)
            $0.left.right.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
