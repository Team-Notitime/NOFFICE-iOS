//
//  SignupViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import RxSwift
import RxCocoa

public class SignupViewController: BaseViewController<SignupView> {
    // MARK: Setup
    public override func setupBind() {
        baseView.dummyButton
            .onTap
            .subscribe(onNext: {
                Router.shared.push(SignupFunnelViewController())
            })
            .disposed(by: disposeBag)
    }
}
