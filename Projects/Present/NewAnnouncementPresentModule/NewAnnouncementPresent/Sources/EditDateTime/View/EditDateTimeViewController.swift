//
//  EditDateTimeViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import Router
import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class EditDateTimeViewController: BaseViewController<EditDateTimeView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditDateTimeReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { 
        // - Bind date
        reactor.state.map { $0.selectedDate }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: baseView.calendarView.selectedDate)
            .disposed(by: disposeBag)
        
        // - Bind time
        reactor.state.map { $0.selectedTime }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: baseView.timePicker.selectedTime)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        // - Tap back button
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
        
        // - Change selected date
        baseView.calendarView
            .onChangeSelectedDate
            .map { date in
                .changeSelectedDate(date)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Change selected time
        baseView.timePicker
            .onChangeSelectedTime
            .map { dateComponent in
                .changeSelectedTime(dateComponent)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap reset button
        baseView.resetButton
            .onTap
            .map { _ in .reset }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
