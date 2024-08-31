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

class NewOrganizationCategoryPageView: BaseView {
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Funnel header
    lazy var funnelHeader = NofficeFunnelHeader(
        descriptionBuilder: {
            [
                UILabel().then {
                    $0.text = "필수 사항"
                    $0.setTypo(.body2b)
                    $0.textColor = .green500
                }
            ]
        }
    ).then {
        $0.funnelType = .newGroup
        $0.title = "그룹의 카테고리를 모두 선택해주세요"
    }
    
    // - Category list
    lazy var categoryGroup = BaseCheckBoxGroup(
        source: OrganizationCategoryType.allCases.map { $0.toEntity() },
        optionBuilder: { option in
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
        $0.gridStyled(columns: 2, verticalSpacing: 10, horizontalSpacing: 10)
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
        
        contentView.addSubview(funnelHeader)
        
        contentView.addSubview(categoryGroup)
        
        contentView.addSubview(nextPageButton)
    }
    
    override func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
        }
        
        funnelHeader.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        categoryGroup.snp.makeConstraints {
            $0.top.equalTo(funnelHeader.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.SpacingUnit * 2)
        }
    }
}
