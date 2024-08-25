//
//  AnnouncementPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//
import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

class AnnouncementPageView: BaseView {
    // MARK: UI Component
    // - Announcement collection view
    lazy var collectionView = CompositionalCollectionView()
    
    // - Has leader role organization dialog
    lazy var hasLeaderRoleOrganizationDialog = BaseDialog(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "참여한 그룹이 없어요"
                }
            ]
        }
    ).then {
        $0.styled()
    }

    // MARK: Setup
    override func setupHierarchy() {
        addSubview(collectionView)
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // bottom margin
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 32,
            right: 0
        )
    }
}
