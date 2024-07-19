//
//  NewOrganizationCategoryPageView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem
import Assets
import OrganizationEntity

import SnapKit
import Then

public class NewOrganizationCategoryPageView: BaseView {
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
        $0.text = "그룹의 카테고리를 모두 선택해주세요."
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Category list
    lazy var nameCountLabel = UILabel().then {
        $0.text = "0/\(OrganizationConstant.maxOrganizationNameLength)"
        $0.setTypo(.body3)
    }
    
    lazy var categoryGroup = BaseCheckBoxGroup(
        source: OrganizationCategoryType.allCases.map { $0.toEntity() },
        itemBuilder: { option in
            NofficeList(option: option) { _ in
                [
                    UILabel().then {
                        $0.text = "\(option.name)"
                        $0.setTypo(.body2b)
                        $0.textAlignment = .center
                    }
                ]
            }
        }
    ).then {
        $0.gridStyled(columns: 2, verticalSpacing: 10, horizontalSpacing:10)
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
    
    // - Complete button
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
    public override func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(pageSubTitle)
        
        contentView.addSubview(pageTitleLabel)
        
        contentView.addSubview(categoryGroup)
        
        contentView.addSubview(nextPageButton)
    }
    
    public override func setupLayout() {
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
        
        categoryGroup.snp.makeConstraints {
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
