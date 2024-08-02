//
//  HomeViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import RxSwift
import RxCocoa
import RxGesture

public final class HomeTabViewController: BaseViewController<HomeTabView> {
    // MARK: Setup
    public override func setupViewBind() {
        // - Synchronize paginable view and segment
        baseView.paginableView.onMove
            .bind(to: baseView.segmentControl.selectedOption)
            .disposed(by: disposeBag)
        
        // - Synchronize paginable view and segment
        baseView.segmentControl.onChange
            .withUnretained(self)
            .subscribe(onNext: { owner, page in
                owner.baseView.paginableView.currentPage = page
            })
            .disposed(by: disposeBag)
        
        // - Tap mypage icon
        baseView.mypageButton.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                Router.shared.push(.mypage)
            }
            .disposed(by: disposeBag)
    }
}
