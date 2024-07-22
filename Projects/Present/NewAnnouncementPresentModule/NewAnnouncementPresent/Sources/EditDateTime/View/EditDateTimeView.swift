//
//  EditDateTimeView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class EditDateTimeView: BaseView {
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "날짜 선택"
    }
    
    // - Scroll view
    lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    // - Content view
    lazy var contentView = UIView()
    
    // - Title
    lazy var titleLabel = UILabel().then {
        $0.text = "이벤트 일시를 선택해주세요"
        $0.textColor = .grey800
        $0.setTypo(.heading3)
    }
    
    // - Calendar
    lazy var calendarView = BaseCalendar(previousDateDisabled: true)
    
    // MARK: Setup
    override func setupHierarchy() { 
        addSubview(navigationBar)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(calendarView)
    }
    
    override func setupLayout() { 
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.width.equalTo(scrollView.snp.width)
                .inset(GlobalViewConstant.pagePadding)
            $0.height.equalTo(1000)
            
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(360)
        }
    }
}
