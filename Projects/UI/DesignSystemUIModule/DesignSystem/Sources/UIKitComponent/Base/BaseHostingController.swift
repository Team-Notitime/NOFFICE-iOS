//
//  BaseHostingController.swift
//  DesignSystemModule
//
//  Created by HUNHEE LEE on 21.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

open class BaseHostingController<Content: View>: UIViewController, BaseViewControllerProtocol, UIScrollViewDelegate {
  
  public var hostingController: UIHostingController<Content>?
  
  public init(rootView: Content) {
    super.init(nibName: nil, bundle: nil)
    self.hostingController = UIHostingController(rootView: rootView)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let hostingController = hostingController else { return }
    
    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)
    
    hostingController.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    setupViewBind()
    setupStateBind()
    setupActionBind()
    setupHideKeyboardOnTap()
  }
  
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    guard let hostingController = hostingController else { return }
    
    hostingController.view.frame = view.bounds
  }
  
  open func setupViewBind() { }
  
  open func setupStateBind() { }
  
  open func setupActionBind() { }
  
  private func setupHideKeyboardOnTap() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(hideKeyboard)
    )
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func hideKeyboard() {
    view.endEditing(true)
  }
  
  // MARK: - Scroll view delegate
  public func setupDismissKeyboardOnScroll(in scrollView: UIScrollView) {
    scrollView.delegate = self
  }
  
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
}
