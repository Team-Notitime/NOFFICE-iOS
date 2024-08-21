//
//  OrganizationView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class OrganizationTabView: BaseView {
    // MARK: UI Component
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
    
    // - Organization list collection view
    let collectionView = CompositionalCollectionView()
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(topBarStackView)
        addSubview(collectionView)
    }
    
    public override func setupLayout() { 
        topBarStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topBarStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
public extension OrganizationTabView { 
    enum Page: CaseIterable, Identifiable {
        case organization
        
        var krName: String {
            switch self {
            case .organization: return "그룹"
            }
        }
        
        public var id: String {
            return String(describing: "\(self))")
        }
    }
}
