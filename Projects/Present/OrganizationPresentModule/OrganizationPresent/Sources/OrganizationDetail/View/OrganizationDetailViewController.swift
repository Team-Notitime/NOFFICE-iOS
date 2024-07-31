//
//  OrganizationDetailViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import UIKit

import DesignSystem
import OrganizationEntity

import RxSwift
import RxCocoa
import Swinject

class OrganizationDetailViewController: BaseViewController<OrganizationDetailView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(OrganizationDetailReactor.self)!
    
    // MARK: Data
    private let organization: OrganizationEntity
    
    // MARK: Initialzier
    public init(organization: OrganizationEntity) {
        self.organization = organization
        
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { }
    
    override func setupActionBind() { }
}
