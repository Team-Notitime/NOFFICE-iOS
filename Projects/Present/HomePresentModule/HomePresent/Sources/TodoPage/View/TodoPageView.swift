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

    // MARK: UI Constant
    
    // MARK: UI Component
    lazy var collectionView = CompositionalCollectionView()
    
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
