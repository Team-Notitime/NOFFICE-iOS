//
//  EditDateTimeViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa

class EditDateTimeViewController: BaseViewController<EditDateTimeView> {
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { }
    
    override func setupActionBind() { 
        // - Tap back button
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
    }
}
