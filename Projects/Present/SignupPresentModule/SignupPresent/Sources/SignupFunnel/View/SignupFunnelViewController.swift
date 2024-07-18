//
//  SignupFunnelViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import DesignSystem
import Assets

import Swinject
import RxSwift
import RxCocoa
import ReactorKit

public class SignupFunnelViewController: BaseViewController<SignupFunnelView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupFunnelReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { 
        reactor.state.map { $0.currentPage }
            .withUnretained(self)
            .subscribe(onNext: { owner, page in
                owner.baseView.paginableView.currentPage = page
            })
          .disposed(by: self.disposeBag)
    }
    
    public override func setupActionBind() {
        
    }
}
