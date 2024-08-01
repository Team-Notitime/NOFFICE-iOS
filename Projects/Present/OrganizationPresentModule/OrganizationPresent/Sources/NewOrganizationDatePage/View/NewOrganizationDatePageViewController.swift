//
//  NewOrganizationEndDatePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationDatePageViewController: BaseViewController<NewOrganizationDatePageView> {
    // MARK: ReactorNewOrganizationEndDatePageViewController
    private let reactor = Container.shared.resolve(NewOrganizationDatePageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
        // - Next page button active state
        reactor.state.map { $0.nextPageButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextPageButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
        
        // - Selected date
        reactor.state.map { $0.selectedDate }
            .withUnretained(self)
            .subscribe(onNext: { owner, date in
                owner.baseView.selectedDateLabel.text = date?
                    .toString(format: "yyyy-MM-dd")
                
                UIView.animate(withDuration: 0.3) {
                    let opacity: CGFloat = date == nil ? 0 : 1
                    owner.baseView.selectedDateLabelBackgroundView.alpha = opacity
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    override func setupActionBind() {
        // - Select date
        baseView.calendar
            .onChangeSelectedDate
            .map { .changeSelectedDate($0)}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
            
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
