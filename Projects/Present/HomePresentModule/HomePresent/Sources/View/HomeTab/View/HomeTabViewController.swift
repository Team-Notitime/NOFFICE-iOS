//
//  HomeViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

import DesignSystem
import Assets

public final class HomeTabViewController: BaseViewController<HomeTabView> {
    // MARK: Setup
    public override func setupBind() {
        baseView.paginableView.onMove
            .bind(to: baseView.segmentControl.selectedOption)
            .disposed(by: disposeBag)
        
        baseView.segmentControl.onChange
            .withUnretained(self)
            .subscribe(onNext: { owner, page in
                owner.baseView.paginableView.selectedPage = page
            })
            .disposed(by: disposeBag)
    }
}
