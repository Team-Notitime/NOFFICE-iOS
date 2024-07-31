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
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad)
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
                        Router.shared.push(NewOrganizationFunnelViewController())
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
