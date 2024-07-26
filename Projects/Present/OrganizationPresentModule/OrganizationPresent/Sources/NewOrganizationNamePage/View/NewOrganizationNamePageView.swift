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
        $0.title = "그룹의 이름이 무엇인가요?"
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
        
        contentView.addSubview(funnelHeader)
        
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
        
        funnelHeader.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(funnelHeader.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
