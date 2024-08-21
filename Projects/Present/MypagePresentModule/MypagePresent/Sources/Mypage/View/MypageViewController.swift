//
//  MypageViewController.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/2/24.
//

import DesignSystem
import Router
import RxCocoa
import RxSwift
import Swinject
import UIKit

public class MypageViewController: BaseViewController<MypageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(MypageReactor.self)!
    
    // MARK: Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad)
    }
    
    // MARK: Setup
    override public func setupViewBind() {}
    
    override public func setupStateBind() {
        reactor.state.map { $0.member }
            .compactMap { $0 }
            .debug(":::")
            .subscribe(with: self, onNext: { owner, member in
                owner.baseView.userNameLabel.text = member.name
            })
            .disposed(by: disposeBag)
    }
    
    override public func setupActionBind() {
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
