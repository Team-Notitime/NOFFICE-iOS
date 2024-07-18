//
//  SingupRealNameViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

public class SignupRealNameViewController: BaseViewController<SignupRealNameView> {
    // MARK: Constant
    private let maxNameLength: Int = 15
    
    // MARK: Reactor
    private let reactor: SignupRealNameReactor = Container.shared.resolve(SignupRealNameReactor.self)!
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false // warning
    }
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() {
        // - Complete button active state
        reactor.state.map { $0.completeButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.completeButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.name }
            .bind(to: baseView.nameTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    public override func setupActionBind() {
        // - Text field
        baseView.nameTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .map { owner, text -> String in
                if text.count > owner.maxNameLength {
                    return String(text.prefix(owner.maxNameLength))
                }
                return text
            }
            .map { SignupRealNameReactor.Action.changeName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap next page button
        baseView.completeButton
            .onTap
            .map { _ in .tapCompleteButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
