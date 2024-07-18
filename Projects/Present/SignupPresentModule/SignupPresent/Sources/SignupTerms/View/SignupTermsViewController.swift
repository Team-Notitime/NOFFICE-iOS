//
//  SignupTermsViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import Router
import DesignSystem

import Swinject
import ReactorKit
import RxSwift
import RxCocoa
import RxGesture

public class SignupTermsViewController: BaseViewController<SignupTermsView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupTermsReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() {
        // - All agree check
        baseView.allAgreeCheckBox
            .onChangeSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, selected in
                if selected {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = SignupTermsReactor.TermOptionType.allCases
                        .map { $0.termOption }
                } else {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = []
                }
            })
            .disposed(by: disposeBag)
        
        // - Tap url icon
        baseView.termsOptionIconViews.enumerated()
            .forEach { _, icon in
                icon.rx.tapGesture()
                    .when(.recognized)
                    .subscribe(onNext: { _ in
                        print("눌렸다앙")
                    })
                    .disposed(by: self.disposeBag)
            }
    }
    
    public override func setupStateBind() {
        // - Next button active state
        reactor.state.map { $0.nextButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
    }
    
    public override func setupActionBind() {
        // - Select term option
        baseView.termsOptonGroup
            .onChangeSelectedOptions
            .map { options in
                    .changeSelectedTermOptions(
                        options.map { $0.type }.compactMap { $0 }
                    )
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // - Tap next page button
        baseView.nextButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
