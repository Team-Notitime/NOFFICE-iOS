//
//  NewOrganizationViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa

public class NewOrganizationFunnelViewController: BaseViewController<NewOrganizationFunnelView> {
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { }
    
    public override func setupActionBind() { 
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.back()
            })
            .disposed(by: disposeBag)
    }
}
