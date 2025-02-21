//
//  WithdrawViewController.swift
//  MypagePresent
//
//  Created by HUNHEE LEE on 18.02.2025.
//

import DesignSystem
import Router
import UIKit
import Swinject

public class WithdrawViewController: BaseViewController<WithdrawView> {
  
  private let reactor = Container.shared.resolve(MypageReactor.self)!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .grey50
  }
  
  public override func setupViewBind() {
    baseView.termOption.onChangeSelected
      .subscribe(with: self) { owner, selected in
        owner.baseView.nextButton.isEnabled = selected
      }
      .disposed(by: disposeBag)
  }
  
  public override func setupActionBind() {
    baseView.nextButton.onTap
      .do { [weak self] _ in
        self?.reactor.action.onNext(.tapWithdrawRow)
      }
      .bind { _ in
        Router.shared.push(.signup, animated: false)
      }
      .disposed(by: disposeBag)
  }
}
