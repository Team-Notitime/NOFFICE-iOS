//
//  NewOrganizationImagePageView.swift
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

class NewOrganizationImagePageView: BaseView {
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
        $0.title = "대표 이미지를 설정해주세요"
    }
    
    // - Category list
    lazy var nameCountLabel = UILabel().then {
        $0.text = "0/\(OrganizationConstant.maxOrganizationNameLength)"
        $0.setTypo(.body3)
    }
    
    lazy var imageView = UIImageView().then {
        $0.backgroundColor = .grey50
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
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
        $0.isEnabled = true // always enabled
    }
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(funnelHeader)
        
        contentView.addSubview(imageView)
        
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
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(funnelHeader.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(280)
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.SpacingUnit * 2)
        }
    }
}
