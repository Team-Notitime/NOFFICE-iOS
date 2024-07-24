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
    lazy var header = NofficeFunnelHeader().then {
        $0.funnelType = .newAnnouncement
        $0.title = "이벤트 일시를 선택해주세요"
    }
    
    // - Calendar
    lazy var calendarView = BaseCalendar(previousDateDisabled: true)
    
    // - Time picker
    lazy var timePicker = BaseTimePicker()
    
    // - Reset button
    lazy var resetButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "초기화"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .ghost, size: .small)
    }
    
    // - Save button
    lazy var saveButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "저장"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green, size: .medium)
    }
    
    // MARK: Setup
    override func setupHierarchy() { 
        addSubview(navigationBar)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(header)
        
        contentView.addSubview(calendarView)
        
        contentView.addSubview(timePicker)
        
        contentView.addSubview(resetButton)
        
        addSubview(saveButton)
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
            $0.width.equalTo(scrollView.frameLayoutGuide)
                .inset(GlobalViewConstant.pagePadding)
        }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
            $0.height.equalTo(CGFloat.infinityWidth*0.8)
        }
        
        timePicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
            $0.top.equalTo(calendarView.snp.bottom)
                .offset(FunnelConstant.spacingUnit)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.bottom)
                .offset(-FunnelConstant.spacingUnit * 8)
        }
        
        saveButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                .inset(FunnelConstant.spacingUnit)
        }
    }
}
