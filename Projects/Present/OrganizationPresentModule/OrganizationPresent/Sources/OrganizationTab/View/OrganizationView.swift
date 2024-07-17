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
    lazy var topBarBackgroundView = BaseHStack(
        contents: [
            BaseSpacer(size: GlobalViewConstant.pagePadding / 2, orientation: .horizontal),
            segmentControl,
            BaseSpacer(),
            UIImageView(image: .iconBell).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            },
            UIImageView(image: .iconUser).then {
                $0.tintColor = .grey500
                $0.contentMode = .scaleAspectFit
            },
            BaseSpacer(size: GlobalViewConstant.pagePadding / 2, orientation: .horizontal)
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
    
    let collectionView = CompositionalCollectionView()
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(topBarBackgroundView)
        
        addSubview(collectionView)
    }
    
    public override func setupLayout() { 
        topBarBackgroundView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topBarBackgroundView.snp.bottom)
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
