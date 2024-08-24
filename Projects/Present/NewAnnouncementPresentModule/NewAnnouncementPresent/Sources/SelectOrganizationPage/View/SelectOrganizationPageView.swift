//
//  SelectOrganizationPageView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import UIKit

import DesignSystem
import Assets
import AnnouncementEntity
import OrganizationEntity

import SnapKit
import Then

class SelectOrganizationPageView: BaseView {
    // MARK: UI Component
    // - Background view
    lazy var backgroundView = UIView()
    
    // - Title
    lazy var titleFirstlabel = UILabel().then {
        $0.text = "어떤 노피스에"
        $0.setTypo(.heading3)
        $0.tintColor = .grey800
    }
    
    lazy var titleSecondlabel = UILabel().then {
        $0.text = "노티를 등록할까요?"
        $0.setTypo(.heading3)
        $0.tintColor = .grey800
    }
    
    // - Organization list
    lazy var organizationGroup = BaseRadioGroup<OrganizationSummaryEntity>( // TODO: 추후 스크롤뷰로 변경..
        animation: true
    ) { option in
        NofficeList(option: option) { _ in
            [
                UILabel().then {
                    $0.text = "\(option.name)"
                    $0.setTypo(.body2b)
                    $0.textAlignment = .center
                },
                BaseSpacer(),
                UIImageView(image: .iconCheck).then {
                    $0.setSize(width: 18, height: 18)
                }
            ]
        }
    }.then {
        $0.gridStyled(columns: 1, verticalSpacing: 10, horizontalSpacing: 10)
    }
    
    // - Next button
    lazy var nextButton = BaseButton(
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
        addSubview(backgroundView)
        
        backgroundView.addSubview(titleFirstlabel)
        
        backgroundView.addSubview(titleSecondlabel)
        
        backgroundView.addSubview(organizationGroup)
        
        backgroundView.addSubview(nextButton)
    }
    
    override func setupLayout() { 
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
        }
        
        titleFirstlabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .inset(FunnelConstant.SpacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.AdditionalPadding)
        }
        
        titleSecondlabel.snp.makeConstraints {
            $0.top.equalTo(titleFirstlabel.snp.bottom)
                .offset(FunnelConstant.SpacingUnit / 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.AdditionalPadding)
        }
        
        organizationGroup.snp.makeConstraints {
            $0.top.equalTo(titleSecondlabel.snp.bottom)
                .offset(FunnelConstant.SpacingUnit * 2)
            $0.left.right.equalToSuperview()
            
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.SpacingUnit)
        }
    }
}
