//
//  NewOrganizationView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import SnapKit
import Then

public class NewOrganizationView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    lazy var navigationBar = NofficeNavigationBar(
        backButtonAction: { Router.shared.back() }
    )
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(navigationBar)
    }
    
    public override func setupLayout() { 
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
public extension NewOrganizationView { }
