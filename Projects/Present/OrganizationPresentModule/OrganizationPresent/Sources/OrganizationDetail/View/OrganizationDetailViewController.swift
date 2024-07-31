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

class OrganizationDetailViewController: BaseViewController<OrganizationDetailView> {
    
    // MARK: Data
    private let organization: OrganizationEntity
    
    // MARK: Initialzier
    // example app 때문에 임시로 optional 처리
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
