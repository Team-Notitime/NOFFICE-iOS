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

class NewOrganizationNamePageView: BaseView {
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
        $0.text = "그룹의 이름이 무엇인가요?"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Textfield
    lazy var nameCountLabel = UILabel().then {
        $0.text = "0/\(OrganizationConstant.maxOrganizationNameLength)"
        $0.setTypo(.body3)
    }

    lazy var nameTextField = BaseTextField(
        descriptionBuilder: {
            [
                BaseSpacer(),
                nameCountLabel
            ]
        }
    ).then {
        $0.placeholder = "그룹명을 입력해주세요"
        $0.styled(variant: .outlined, shape: .round)
    }
    
    // - Next page button
    lazy var nextPageButton = BaseButton(
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
        
        contentView.addSubview(nameTextField)
        
        contentView.addSubview(nextPageButton)
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
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
