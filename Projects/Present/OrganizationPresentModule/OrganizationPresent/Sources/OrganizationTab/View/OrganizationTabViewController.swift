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
import Swinject

public class OrganizationTabViewController: BaseViewController<OrganizationTabView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(OrganizationTabReactor.self)!
    
    // MARK: Life cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reactor.action.onNext(.viewWillAppear)
    }
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() {
        // - Organization collection view
        reactor.state.map { $0.organizations }
            .map {
                OrganizationTabConverter.convert(
                    entities: $0,
                    onTapNewButton: {
                        Router.shared.push(.newOrganization)
                    },
                    onTapOrganizationRow: { organization in
                        Router.shared.push(
                            OrganizationDetailViewController(organization: organization)
                        )
                    }
                )
            }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    public override func setupActionBind() {
    }
}
