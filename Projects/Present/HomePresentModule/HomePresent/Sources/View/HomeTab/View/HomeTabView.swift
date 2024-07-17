//
//  HomeView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/13/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class HomeTabView: BaseView {
    // MARK: UI component
    lazy var topBarBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var segmentControl = BaseSegmentControl(
        source: Page.allCases,
        itemBuilder: { option in
            [
                UILabel().then {
                    $0.text = "\(option.krName)"
                    $0.setTypo(.heading3)
                    $0.textAlignment = .center
                }
            ]
        }
    ).then {
        $0.styled(variant: .underline)
    }
    
    lazy var notificationIcon = UIImageView(image: .iconBell).then {
        $0.tintColor = .grey500
    }
    
    lazy var mypageIcon = UIImageView(image: .iconUser).then {
        $0.tintColor = .grey500
    }
    
    lazy var paginableView = PaginableView<Page>(
        pages: Page.allCases,
        firstPage: Page.announcement
    )
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(topBarBackgroundView)
        
        topBarBackgroundView.addSubview(segmentControl)
        topBarBackgroundView.addSubview(notificationIcon)
        topBarBackgroundView.addSubview(mypageIcon)
        
        addSubview(paginableView)
    }
    
    public override func setupLayout() {
        topBarBackgroundView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        segmentControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(pagePadding)
            $0.width.equalToSuperview().multipliedBy(0.36)
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        mypageIcon.snp.makeConstraints {
            $0.centerY.equalTo(segmentControl.snp.centerY)
            $0.right.equalToSuperview().inset(GlobalViewConstant.pagePadding)
            $0.centerY.equalToSuperview()
        }
        
        notificationIcon.snp.makeConstraints {
            $0.centerY.equalTo(segmentControl.snp.centerY)
            $0.right.equalTo(mypageIcon.snp.left).offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(topBarBackgroundView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
public extension HomeTabView {
    enum Page: CaseIterable, Identifiable, PageType {
        case announcement
        case todo
        
        var krName: String {
            switch self {
            case .announcement: return "노티"
            case .todo: return "투두"
            }
        }
        
        public var id: String {
            return String(describing: "\(self))")
        }
        
        public var viewController: UIViewController {
            switch self {
            case .announcement:
                return AnnouncementPageViewController()
            case .todo:
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow100
                return vc
            }
        }
    }
}

// MARK: - Constant
private extension HomeTabView {
    
}
