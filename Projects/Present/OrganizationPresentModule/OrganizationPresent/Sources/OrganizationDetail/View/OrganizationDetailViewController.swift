//
//  OrganizationDetailViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import UIKit

import Router
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
    override func setupViewBind() { 
        // - Perform JoinWaitlistButton appearance animation
        DispatchQueue.main.async {
            self.animateJoinWaitlistButton()
        }
    }
    
    override func setupStateBind() { }
    
    override func setupActionBind() { 
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: { _ in
                Router.shared.back()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Private
    /// Button appearance animation with scaling effect
    private func animateJoinWaitlistButton() {
        // Initial state
        baseView.joinWaitlistButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        baseView.joinWaitlistButton.alpha = 0.0
        
        // Animation
        UIView.animate(
            withDuration: 0.7,
            delay: 1,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }
                
                baseView.joinWaitlistButton.isHidden = false
                self.baseView.joinWaitlistButton.transform = CGAffineTransform.identity
                self.baseView.joinWaitlistButton.alpha = 1.0
            }, completion: nil
        )
    }
}
