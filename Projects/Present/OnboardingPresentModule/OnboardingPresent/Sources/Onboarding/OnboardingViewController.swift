//
//  OnboardingViewController.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import UIKit
import DesignSystem
import Swinject
import Router
import RxSwift

final public class OnboardingViewController: BaseHostingController<OnboardingView> {
  private let disposeBag = DisposeBag()
  private let reactor: OnboardingReactor = Container.shared.resolve(OnboardingReactor.self)!

  public init() {
    super.init(rootView: OnboardingView(reactor: reactor))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func setupStateBind() {
    reactor.state
      .compactMap(\.finishOnboarding)
      .subscribe { _ in
        Router.shared.pushToPresent(.signup, animated: true)
      }
      .disposed(by: disposeBag)
  }
}
