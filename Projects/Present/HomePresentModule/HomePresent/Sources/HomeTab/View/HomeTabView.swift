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
    // - Top bar
    lazy var topBarStackView = BaseHStack(spacing: 0) {
        [
            BaseSpacer(size: GlobalViewConstant.PagePadding / 2, orientation: .horizontal),
            segmentControl,
            BaseSpacer(),
//            notificationButton, // TODO: 우선 Hide 처리
            BaseSpacer(size: 6, orientation: .horizontal),
            mypageButton,
            BaseSpacer(size: GlobalViewConstant.PagePadding / 2, orientation: .horizontal)
        ]
    }
    
    // - Notification icon
    lazy var notificationButton = BaseButton {
        [
            UIImageView(image: .iconBell).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            }
        ]
    }.then {
        $0.styled(variant: .transparent, color: .ghost, size: .xsmall)
    }
    
    // - Mypage button
    lazy var mypageButton = BaseButton {
        [
            UIImageView(image: .iconUser).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            }
        ]
    }.then {
        $0.styled(variant: .transparent, color: .ghost, size: .xsmall)
    }
    
    // - Page segment control
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
    
    // - Paginable view
    lazy var paginableView = PaginableView<Page>(
        pages: Page.allCases,
        firstPage: Page.announcement
    )
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(topBarStackView)
        
        addSubview(paginableView)
    }
    
    public override func setupLayout() {
        topBarStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(topBarStackView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
// TODO: 1차 배포 후 todo 탭 살리기
public extension HomeTabView {
    enum Page: CaseIterable, Identifiable, Paginable {
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
                return TodoPageViewController()
            }
        }
    }
}
