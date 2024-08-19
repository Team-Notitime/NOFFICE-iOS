//
//  MypageViewController.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/2/24.
//

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa
import Swinject

public class MypageViewController: BaseViewController<MypageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(MypageReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { }
    
    public override func setupActionBind() { 
        // - Bind back button in navigation bar
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.back()
            })
            .disposed(by: disposeBag)
        
        // - Logout
        baseView.logoutRow
            .rx.tapGesture()
            .when(.recognized)
            .map { _ in .tapLogoutRow }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
