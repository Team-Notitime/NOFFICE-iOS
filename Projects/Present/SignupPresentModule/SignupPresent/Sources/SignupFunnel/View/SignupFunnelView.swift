//
//  SignupFunnelView.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import SnapKit
import Then

public class SignupFunnelView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    // - navigation bar
    lazy var navigationBar = NofficeNavigationBar(
        backButtonAction: { Router.shared.back() }
    )
    
    lazy var paginableView = PaginableView<Page>(
        pages: Page.allCases,
        firstPage: Page.terms,
        gestureDisabled: true
    )
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(navigationBar)
        
        addSubview(paginableView)
    }
    
    public override func setupLayout() { 
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
public extension SignupFunnelView { 
    enum Page: String, CaseIterable, PageType {
        case terms
        case realMame
        
        public var viewController: UIViewController {
            switch self {
            case .terms:
                return SignupTermsViewController()
            case .realMame:
                let vc = UIViewController()
                vc.view.backgroundColor = .blue100
                return vc
            }
        }
        
    }
}
