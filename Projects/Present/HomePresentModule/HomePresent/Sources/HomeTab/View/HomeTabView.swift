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
    lazy var topBarBackgroundView = BaseHStack(
        contents: [
            BaseSpacer(size: GlobalViewConstant.PagePadding / 2, orientation: .horizontal),
            segmentControl,
            BaseSpacer(),
            UIImageView(image: .iconBell).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            },
            BaseSpacer(size: 6, orientation: .horizontal),
            UIImageView(image: .iconUser).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            },
            BaseSpacer(size: GlobalViewConstant.PagePadding / 2, orientation: .horizontal)
        ]
    )
    
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
    
    lazy var paginableView = PaginableView<Page>(
        pages: Page.allCases,
        firstPage: Page.announcement
    )
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(topBarBackgroundView)
        
        addSubview(paginableView)
    }
    
    public override func setupLayout() {
        topBarBackgroundView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(topBarBackgroundView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
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
