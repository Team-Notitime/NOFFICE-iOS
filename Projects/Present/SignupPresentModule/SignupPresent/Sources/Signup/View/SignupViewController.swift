//
//  SignupViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit
import AuthenticationServices

import Assets
import DesignSystem
import Router

import RxCocoa
import RxGesture
import RxSwift
import Swinject

public class SignupViewController: BaseViewController<SignupView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { }
    
    public override func setupActionBind() {
        baseView.appleSigninButton
            .rx.tapGesture()
            .when(.recognized)
            .map { _ in .tapAppleSigninButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        baseView.kakaoSigninButton
            .rx.tapGesture()
            .when(.recognized)
            .map { _ in .tapKakaoSigninButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
