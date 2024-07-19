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

public class NewOrganizationEndDatePageView: BaseView {
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
        $0.text = "활동 종료 날짜가 언제인가요?"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Calendar
    lazy var calendar = BaseCalendar()
    
    // - Selecte date label
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
    
    lazy var selectedDateLabelStackView = BaseHStack(spacing: 0) {
        [
            selectedDateLabel,
            selectedDescriptionLabel
        ]
    }.then {
        $0.alpha = 0.0
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
        
        contentView.addSubview(calendar)
        
        contentView.addSubview(nextPageButton)
        
        contentView.addSubview(selectedDateLabelStackView)
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
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding / 2)
            $0.bottom.equalToSuperview()
        }
        
        nextPageButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
        
        selectedDateLabelStackView.snp.makeConstraints {
            $0.bottom.equalTo(nextPageButton.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }
    }
}
