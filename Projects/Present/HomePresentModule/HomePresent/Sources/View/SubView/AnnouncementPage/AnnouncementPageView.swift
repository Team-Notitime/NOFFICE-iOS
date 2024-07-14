//
//  AnnouncementPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//
import UIKit

import DesignSystem

import SnapKit
import Then

public class AnnouncementPageView: BaseView {
    // MARK: Data source
    
    // MARK: UI Component
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var banner = NofficeBanner().then {
        $0.userName = "이즌"
        $0.todayPrefixText = "활기찬"
        $0.dateText = "8월 27일 화요일"
    }
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(banner)
    }
    
    public override func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000) // 임시 높이
        }
        
        banner.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public override func setupBind() { }
}
