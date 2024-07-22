//
//  EditContentsPageViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa
import RxGesture

class EditContentsPageViewController: BaseViewController<EditContentsPageView> {
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { }
    
    override func setupActionBind() { 
        baseView.dateTemplateButton
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in
                owner.dateTemplateButton.status = .selected
                
                Router.shared.pushToPresent(UIViewController())
            })
            .disposed(by: disposeBag)
    }
}
