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

import MainEntity

public protocol SignupTermsPageViewDelegate: AnyObject {
  func termsPageViewController(_ viewController: SignupTermsPageViewController, didRequestPresentTerFile termFile: TermFile, reactor: SignupTermsPageReactor)
}

public class SignupTermsPageViewController: BaseViewController<SignupTermsPageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupTermsPageReactor.self)!
    
    // MARK: Delegate
    public weak var delegate: SignupTermsPageViewDelegate?
  
    // MARK: Setup
    public override func setupViewBind() {
        // - All agree check
        baseView.allAgreeCheckBox
            .onChangeSelected
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, selected in
                if selected {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = TermOptionType.allCases
                        .map { $0.termOption }
                } else {
                    owner.baseView.termsOptonGroup
                        .selectedOptions = []
                }
            })
            .disposed(by: disposeBag)
        
        // - Tap url icon
        baseView.termsOptionIconViews.enumerated()
            .forEach { index, icon in
                icon.rx.tapGesture()
                    .when(.recognized)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] _ in
                        let termFile = TermOptionType.allCases[index].termOption.termFile
                        guard let termFile,
                              let self else { return }
                      self.delegate?.termsPageViewController(self, didRequestPresentTerFile: termFile, reactor: reactor)
                    })
                    .disposed(by: self.disposeBag)
            }
    }
    
    public override func setupStateBind() {
        // - Next button active state
        reactor.state.map { $0.nextButtonActive }
            .distinctUntilChanged()
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
            .distinctUntilChanged()
            .map { options in
                SignupTermsPageReactor.Action.changeSelectedTermOptions(
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
