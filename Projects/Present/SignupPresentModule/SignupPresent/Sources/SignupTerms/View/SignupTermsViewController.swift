//
//  SignupTermsViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import DesignSystem

import RxSwift
import RxCocoa

public class SignupTermsViewController: BaseViewController<SignupTermsView> {
    // MARK: Setup
    public override func setupBind() { 
        baseView.allAgreeCheckBox
            .onChangeSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, selected in
                if selected {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = SignupTermsView.TermOptionType.allCases
                        .map { $0.termOption }
                } else {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = []
                }
            })
            .disposed(by: disposeBag)
    }
}
