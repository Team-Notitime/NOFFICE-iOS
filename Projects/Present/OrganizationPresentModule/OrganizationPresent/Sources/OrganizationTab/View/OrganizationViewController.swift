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
        )
    ]
    
    // MARK: Setup
    public override func setupBind() { 
        baseView.collectionView
            .bindSections(
            to: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
        
        newOrganizationItem.onTapNewButton
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                Router.shared.push(NewOrganizationViewController())
            })
            .disposed(by: disposeBag)
    }
}
