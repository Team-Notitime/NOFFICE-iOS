//
//  OrganizationViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa

public class OrganizationTabViewController: BaseViewController<OrganizationTabView> {
    // MARK: Compositonal
    private lazy var sectionsSubject = BehaviorSubject<[any CompositionalSection]>(value: sections)
    
    private let newOrganizationItem = NewOrganizationItem()
    
    private lazy var sections: [any CompositionalSection] = [
        NewOrganizationSection(
            items: [
                newOrganizationItem
            ]
        ),
        OrganizationSection(
            items: [
                OrganizationItem(organizationName: "CMC 15th"),
                OrganizationItem(organizationName: "즐거운 소모임"),
                OrganizationItem(organizationName: "행복한 스터디")
            ]
        )
    ]
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() {
        baseView.collectionView
            .bindSections(
            to: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
    }
    
    public override func setupActionBind() {
        newOrganizationItem.onTapNewButton
            .withUnretained(self)
            .subscribe(onNext: { _, _ in
                Router.shared.push(NewOrganizationViewController())
            })
            .disposed(by: disposeBag)
    }
}
