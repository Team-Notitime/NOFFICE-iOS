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
  
    private let dimmedView = UIView()
    private let textField = BaseTextField().then {
      $0.styled(variant: .plain, color: .white, size: .medium, shape: .round, state: .normal)
    }

    // MARK: Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad)
    }
    
    // MARK: Setup
    override public func setupViewBind() {
      
      dimmedView.backgroundColor = .black.withAlphaComponent(0.5)
      dimmedView.alpha = 0
      baseView.addSubview(dimmedView)
      dimmedView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      dimmedView.addSubview(textField)
      textField.snp.makeConstraints {
        $0.horizontalEdges.equalToSuperview().inset(16)
        $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
      }
    }
    
    override public func setupStateBind() {
        reactor.state.map { $0.member }
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
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
        
        // - Bind logout row
      baseView.logoutRow.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self) { owner, _ in
              owner.baseView.signOutDialog.open()
            }
            .disposed(by: disposeBag)
      
      baseView.cancel.onTap.subscribe { _ in
          self.baseView.signOutDialog.close()
        }
        .disposed(by: disposeBag)
        
        // - Bind Withdraw row
        baseView.withdrawRow
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self) { _, _ in
              Router.shared.pushViewController(WithdrawViewController(), animated: true)
            }
            .disposed(by: disposeBag)
      
      baseView.signOutButton.onTap
        .map {
          .tapLogoutRow
        }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
      
      baseView.userNameEditButton
        .rx.tapGesture()
        .when(.recognized)
        .subscribe { _ in
            UIView.animate(withDuration: 0.3) {
                self.dimmedView.alpha = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              self.textField.focusTextField()
            }
        }
        .disposed(by: disposeBag)
      
      textField.textField.rx.controlEvent(.editingDidEndOnExit)
        .subscribe { _ in
          print("리턴 버튼 눌림")
          self.dismissEditView()
        }
        .disposed(by: disposeBag)
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissEditView))
      dimmedView.addGestureRecognizer(tapGesture)
    }
  
  @objc private func dismissEditView() {
    UIView.animate(withDuration: 0.3) {
       self.dimmedView.alpha = 0
    }
    self.textField.unfocusTextField()
  }
}
