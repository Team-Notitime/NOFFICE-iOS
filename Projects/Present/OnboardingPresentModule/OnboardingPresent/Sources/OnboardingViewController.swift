//
//  OnboardingViewController.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import UIKit
import DesignSystem

final public class OnboardingViewController: BaseHostingController<OnboardingView> {
  private let reactor: OnboardingReactor
  
  public init(reactor: OnboardingReactor) {
    self.reactor = reactor
    super.init(rootView: OnboardingView(reactor: reactor))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
