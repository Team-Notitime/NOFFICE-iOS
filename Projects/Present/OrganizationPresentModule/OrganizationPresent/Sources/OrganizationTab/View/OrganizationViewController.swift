//
//  OrganizationViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem

import RxSwift
import RxCocoa

public class OrganizationTabViewController: BaseViewController<OrganizationTabView> {
    // MARK: Life cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Compositonal
    private lazy var sectionsSubject = BehaviorSubject<[any CompositionalSection]>(value: sections)
    
    private let sections: [any CompositionalSection] = [
        OrganizationAddSection(
            items: [
                OrganizationAddItem()
            ]
        )
    ]
    
    // MARK: Setup
    public override func setupBind() { 
        baseView.collectionView.bindSections(
            to: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
    }
}
