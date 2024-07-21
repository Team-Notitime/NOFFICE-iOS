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

import SnapKit
import Then

class SelectOrganizationPageView: BaseView {
    // MARK: UI Constant
    
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
//    lazy var categoryGroup = BaseCheckBoxGroup(
//        source: OrganizationCategoryType.allCases.map { $0.toEntity() },
//        itemBuilder: { option in
//            NofficeList(option: option) { _ in
//                [
//                    UILabel().then {
//                        $0.text = "\(option.name)"
//                        $0.setTypo(.body2b)
//                        $0.textAlignment = .center
//                    }
//                ]
//            }
//        }
//    ).then {
//        $0.gridStyled(columns: 2, verticalSpacing: 10, horizontalSpacing: 10)
//    }
    
    // MARK: Setup
    override func setupHierarchy() { 
        addSubview(backgroundView)
        
        backgroundView.addSubview(titleFirstlabel)
        backgroundView.addSubview(titleSecondlabel)
    }
    
    override func setupLayout() { 
        backgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        titleFirstlabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .inset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        titleSecondlabel.snp.makeConstraints {
            $0.top.equalTo(titleFirstlabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit / 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
    }
    
    func setupMyOrganization() {
        
    }
}
