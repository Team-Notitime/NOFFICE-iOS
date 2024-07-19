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

import RxSwift
import SnapKit
import Then

public class SignupFunnelView: BaseView {
    // MARK: Data
    let pages = Array(SignupFunnelPage.allCases)
    
    // MARK: UI Constant
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar()
    
    // - Paginable bar
    lazy var paginableView = PaginableView(
        pages: pages,
        firstPage: .terms
    ).then {
        $0.gestureScrollEnabled = false
    }
    
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
extension SignupFunnelPage: Paginable {
    public var viewController: UIViewController {
        switch self {
        case .terms:
            return SignupTermsPageViewController()
        case .realName:
            return SignupRealNamePageViewController()
        }
    }
}
