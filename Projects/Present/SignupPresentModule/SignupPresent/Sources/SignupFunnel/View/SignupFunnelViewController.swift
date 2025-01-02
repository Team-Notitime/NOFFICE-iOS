//
//  SignupFunnelViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import Swinject
import RxSwift
import RxCocoa
import ReactorKit
import MainEntity

public class SignupFunnelViewController: BaseViewController<SignupFunnelView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupFunnelReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { 
        reactor.state.map { $0.currentPage }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, page in
                owner.paginableView.currentPage = page
            })
          .disposed(by: self.disposeBag)
    }
    
    public override func setupActionBind() {
        baseView.navigationBar
            .onTapBackButton
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in

                guard let currentPage = owner.paginableView.currentPage,
                      let currentPageIndex = owner.pages.firstIndex(where: { $0 == currentPage })
                else { return }
                
                if currentPageIndex < 1 {
                    Router.shared.dismiss()
                    Router.shared.back()
                } else {
                    owner.paginableView.currentPage = owner.pages[currentPageIndex - 1]
                }
            })
            .disposed(by: disposeBag)
    }
  
    public override func viewDidLoad() {
      super.viewDidLoad()
      setupPageDelegates()
    }
    
    private func setupPageDelegates() {
      if let termsVC = baseView.paginableView.viewController(for: .terms) as? SignupTermsPageViewController {
        termsVC.delegate = self
      }
    }
}

extension SignupFunnelViewController: SignupTermsPageViewDelegate {
  public func termsPageViewController(_ viewController: SignupTermsPageViewController, didRequestPresentTerFile termFile: TermFile, reactor: SignupTermsPageReactor) {
    let termsDetailVC = TermsDetailBottomSheetController(termFile: termFile, reactor: reactor)
    self.present(termsDetailVC, animated: true)
  }
}
