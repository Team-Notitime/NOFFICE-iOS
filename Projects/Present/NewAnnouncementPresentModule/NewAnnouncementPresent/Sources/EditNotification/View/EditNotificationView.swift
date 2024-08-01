//
//  EditNotificationView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class EditNotificationView: BaseView {
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "알림"
    }
    
    // - Content view
    lazy var contentView = UIView()
    
    // - Title
    lazy var header = NofficeFunnelHeader().then {
        $0.funnelType = .newAnnouncement
        $0.title = "멤버에게 전달될\n리마인드 알림을 설정할까요?"
    }
    
    // - Selected reminder time collection view
    lazy var reminderCollectionView = CompositionalCollectionView().then {
        $0.isScrollEnabled = false
    }
    
    // - Reminder time option collection view
    lazy var timeOptionCollectionView = CompositionalCollectionView()
    
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
        $0.styled(variant: .fill, color: .green)
    }
    
    // MARK: Setup
    override func setupHierarchy() { 
        addSubview(navigationBar)
        
        addSubview(contentView)
        
        contentView.addSubview(header)
        
        contentView.addSubview(reminderCollectionView)
        
        contentView.addSubview(timeOptionCollectionView)
        
        contentView.addSubview(saveButton)
    }
    
    override func setupLayout() { 
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
        }
        
        reminderCollectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        timeOptionCollectionView.snp.makeConstraints {
            $0.top.equalTo(reminderCollectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(saveButton.snp.top)
        }
        
        saveButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                .inset(FunnelConstant.SpacingUnit)
        }
    }
}
