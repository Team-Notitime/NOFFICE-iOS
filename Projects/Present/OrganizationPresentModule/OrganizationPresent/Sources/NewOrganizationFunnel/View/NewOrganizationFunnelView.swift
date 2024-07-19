//
//  NewOrganizationView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class NewOrganizationFunnelView: BaseView {
    // MARK: Data
    let pages = Array(NewOrganizationFunnelPage.allCases)
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar()
    
    // - Paginable bar
    lazy var paginableView = PaginableView(
        pages: pages,
        firstPage: .name
    ).then {
        $0.gestureScrollEnabled = false
    }
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(navigationBar)
        
        addSubview(paginableView)
    }
    
    override func setupLayout() { 
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
extension NewOrganizationFunnelPage: Paginable {
    var viewController: UIViewController {
        switch self {
        case .name:
            return NewOrganizationNamePageViewController()
        case .category:
            return NewOrganizationCategoryPageViewController()
        case .image:
            return NewOrganizationImagePageViewController()
        case .endDate:
            return NewOrganizationEndDatePageViewController()
        case .promotion:
            return NewOrganizationPromotionPageViewController()
        case .complete:
            return NewOrganizationCompletePageViewController()
        }
    }
}
