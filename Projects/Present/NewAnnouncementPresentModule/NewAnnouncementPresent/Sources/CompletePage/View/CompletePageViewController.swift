//
//  NewAnnouncementCompleteViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/25/24.
//

import DesignSystem
import Router
import RxCocoa
import RxSwift
import UIKit

class CompletePageViewController: BaseViewController<CompletePageView> {
    // MARK: Setup
    override func setupViewBind() {}

    override func setupStateBind() {}

    override func setupActionBind() {
        baseView.goHomeButton
            .onTap
            .subscribe(onNext: {
                Router.shared.dismiss()
            })
            .disposed(by: disposeBag)
    }
}
