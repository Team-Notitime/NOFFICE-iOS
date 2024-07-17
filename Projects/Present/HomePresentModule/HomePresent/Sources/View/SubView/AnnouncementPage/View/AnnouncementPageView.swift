//
//  AnnouncementPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//
import UIKit

import DesignSystem

import RxSwift
import RxCocoa
import SnapKit
import Then

public class AnnouncementPageView: BaseView {
    // MARK: Data source
    
    // MARK: UI Component
    let collectionView = CompositionalCollectionView()
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(collectionView)
    }
    
    public override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
