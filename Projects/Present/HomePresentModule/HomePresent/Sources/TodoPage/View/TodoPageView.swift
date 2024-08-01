//
//  TodoPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class TodoPageView: BaseView {
    // MARK: UI Component
    lazy var collectionView = CompositionalCollectionView().then {
        $0.contentInset = .init(
            top: GlobalViewConstant.PagePadding,
            left: 0,
            bottom: GlobalViewConstant.PagePadding,
            right: 0
        )
    }
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(collectionView)
    }
    
    public override func setupLayout() {
        collectionView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
