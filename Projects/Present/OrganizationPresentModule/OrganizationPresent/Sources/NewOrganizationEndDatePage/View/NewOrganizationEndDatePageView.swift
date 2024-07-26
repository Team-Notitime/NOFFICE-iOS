//
//  NewOrganizationEndDatePageView.swift
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

class NewOrganizationEndDatePageView: BaseView {
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
        $0.title = "활동 종료 날짜가 언제인가요?"
    }
    
    // - Calendar
    lazy var calendar = BaseCalendar(previousDateDisabled: true)
    
    // - Selecte date label
    lazy var selectedDateLabelBackgroundView = UIView().then {
        $0.backgroundColor = .green100
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.alpha = 0.0
    }
    
    lazy var selectedDateLabelStackView = BaseHStack(spacing: 0) {
        [
            selectedDateLabel,
            selectedDescriptionLabel
        ]
    }
    
    lazy var selectedDateLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.body1b)
        $0.textColor = .green800
    }
    
    lazy var selectedDescriptionLabel = UILabel().then {
        $0.text = "에 활동을 종료할 예정이에요!"
        $0.setTypo(.body1b)
        $0.textColor = .grey400
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
        
        contentView.addSubview(calendar)
        
        contentView.addSubview(nextPageButton)
        
        contentView.addSubview(selectedDateLabelBackgroundView)
        
        selectedDateLabelBackgroundView.addSubview(selectedDateLabelStackView)
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
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(funnelHeader.snp.bottom)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding / 2)
            $0.bottom.equalToSuperview()
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
        
        selectedDateLabelBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(nextPageButton.snp.top).offset(-64)
            $0.centerX.equalToSuperview()
        }
        
        selectedDateLabelStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(12)
            $0.left.right.equalToSuperview()
                .inset(16)
        }
    }
}
