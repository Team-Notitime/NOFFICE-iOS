//
//  HomeViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

import DesignSystem
import Assets

public final class HomeViewController: BaseViewController<HomeView> {
    
    // MARK: Life cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
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
