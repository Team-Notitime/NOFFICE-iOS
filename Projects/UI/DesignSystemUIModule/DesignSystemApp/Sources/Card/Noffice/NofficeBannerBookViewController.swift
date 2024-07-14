//
//  NofficeBannerBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/15/24.
//

import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

class NofficeBannerBookViewController: UIViewController {
    // MARK: UI Components
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private lazy var banner = NofficeBanner().then {
        $0.userName = "이즌"
        $0.todayPrefixText = "활기찬"
        $0.dateText = "8월 27일 화요일"
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(banner)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        banner.snp.makeConstraints { make in
            make.height.equalTo(200) // 원하는 높이로 설정
        }
    }

    private func setupBind() { }
}
